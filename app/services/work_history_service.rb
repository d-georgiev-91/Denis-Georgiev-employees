require 'csv'

class WorkHistoryService
  def process(file_path)
    data = []

    CSV.foreach(file_path, headers: true) do |row|
      emp_id = row['EmpID']
      project_id = row['ProjectID']
      date_from = Date.parse row['DateFrom']
      date_to = row['DateTo'].present? && row['DateTo'].downcase != 'null' ? Date.parse(row['DateTo']) : Date.today

      data << { emp_id: emp_id, project_id: project_id, date_from: date_from, date_to: date_to }
    end

    # Group data by project
    projects = data.group_by { |d| d[:project_id] }
    project_pairs = []

    # Calculate maximum overlap for each project
    projects.each do |project_id, entries|
      # Sort entries by date_from, then by date_to in descending order for proper overlap checking
      sorted_entries = entries.sort_by do |entry|
        [entry[:date_from], -entry[:date_to].to_time.to_i]
      end

      current_reference = sorted_entries.first
      max_overlap = 0
      pair = {}

      sorted_entries[1..-1].each do |current|
        current_start = current[:date_from]
        current_end = current[:date_to]

        # Calculate overlap with current_reference
        overlap = [current_reference[:date_to], current_end].min - current_start
        overlap = overlap.to_i + 1 # plus one to include both start and end days in count

        # Check if this is the maximum overlap found so far for this project
        if overlap > max_overlap
          max_overlap = overlap
          pair[:emp_id_1] = current_reference[:emp_id]
          pair[:emp_id_2] = current[:emp_id]
          pair[:days_worked] = overlap
        end

        # Update current_reference if current interval ends later than current_reference
        if current_end > current_reference[:date_to]
          current_reference = current
        end
      end

      # Only store if there was an overlap
      if max_overlap > 0
        project_pairs << {
          emp_id_1: pair[:emp_id_1],
          emp_id_2: pair[:emp_id_2],
          project_id: project_id,
          days_worked: pair[:days_worked]
        }
      end
    end

    project_pairs.sort_by {|pair| pair[:project_id].to_i }
  end
end
