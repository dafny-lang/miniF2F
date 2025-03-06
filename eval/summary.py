import json
import csv
from collections import defaultdict

# Categories to track
categories = [
    "/amc",
    "/aime",
    "/imo",
    "/mathd_algebra",
    "/mathd_numbertheory",
    "/induction",
    "/algebra",
    "/numbertheory"
]

def write_summary(results_path, summary_path):
    # Initialize dictionary to store counts
    category_verified_counts = defaultdict(int)
    category_counts = defaultdict(int)

    # Read and process the JSON file
    try:
        with open(results_path, 'r') as json_file:
            data = json.load(json_file)
            
            # Process each entry in the JSON list
            for entry in data:
                # Check if the entry is verified
                    # Get the id from the entry
                    problem_id = entry.get('id', '')
                    # Check which category this entry belongs to
                    for category in categories:
                        if category in problem_id:
                            if entry.get('result', '') == "verified":
                                category_verified_counts[category] += 1
                            category_counts[category] += 1
                            break  # Each entry should only count for one category

        # Write results to CSV
        with open(summary_path, 'w', newline='') as csv_file:
            writer = csv.writer(csv_file)
            
            # Write header
            writer.writerow(['bucket', '# lemmas', '# lemmas verified with empty proof', "% lemmas verified with empty proof"])
            
            total_lemmas = 0
            total_verified_lemmas = 0
            # Write counts for each category
            for category in categories:
                writer.writerow([category, category_counts[category], category_verified_counts[category], category_verified_counts[category]/category_counts[category]*100])
                total_lemmas += category_counts[category]
                total_verified_lemmas += category_verified_counts[category]
            
            writer.writerow(['total', total_lemmas, total_verified_lemmas, total_verified_lemmas/total_lemmas*100])

        print("CSV file has been created successfully!")

    except FileNotFoundError:
        print("Error: JSON file not found!")
    except json.JSONDecodeError:
        print("Error: Invalid JSON format in results.json!")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

def main() -> None:
  write_summary('results/dafny/test/results.json', 'results/dafny/test/summary.csv')
  write_summary('results/dafny/valid/results.json', 'results/dafny/valid/summary.csv')

if __name__ == "__main__":
  main()