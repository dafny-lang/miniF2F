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

# Number of problems in each category for test folder
category_full_counts_test = {
    "/amc": 45,
    "/aime": 15,
    "/imo": 20,
    "/mathd_algebra": 70,
    "/mathd_numbertheory": 60,
    "/induction": 8,
    "/algebra": 18,
    "/numbertheory": 8
}

# Number of problems in each category for valid folder
category_full_counts_valid = {
    "/amc": 45,
    "/aime": 15,
    "/imo": 20,
    "/mathd_algebra": 70,
    "/mathd_numbertheory": 60,
    "/induction": 8,
    "/algebra": 18,
    "/numbertheory": 8
}

def write_summary(folder):
    # Set results path
    if folder == 'test':
        results_path = 'results/dafny/test/results.json'
        summary_path = 'results/dafny/test/summary.csv'
        category_full_counts = category_full_counts_test
    else:
        results_path = 'results/dafny/valid/results.json'
        summary_path = 'results/dafny/valid/summary.csv'
        category_full_counts = category_full_counts_valid

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
            writer.writerow(['category', '# lemmas', '# lemmas verified with empty proof', "% lemmas verified with empty proof"])
            
            total_lemmas = 0
            total_verified_lemmas = 0
            # Write counts for each category
            for category in categories:
                category_verified_counts_percentage = category_verified_counts[category]/category_counts[category]*100
                category_full_verified_counts_percentage = category_verified_counts[category]/category_full_counts[category]*100
                writer.writerow([category, f'{category_counts[category]} ({category_full_counts[category]})', category_verified_counts[category], f'{category_verified_counts_percentage} ({category_full_verified_counts_percentage})'])
                total_lemmas += category_counts[category]
                total_verified_lemmas += category_verified_counts[category]
            
            total_verified_lemmas_percentage = total_verified_lemmas/total_lemmas*100
            total_full_verified_lemmas_percentage = total_verified_lemmas/244*100
            total_percentage = total_lemmas / 244 * 100
            writer.writerow([f'total ({total_percentage})', f'{total_lemmas} (244)', total_verified_lemmas, f'{total_verified_lemmas_percentage} ({total_full_verified_lemmas_percentage})'])

        print("CSV file has been created successfully!")

    except FileNotFoundError:
        print("Error: JSON file not found!")
    except json.JSONDecodeError:
        print("Error: Invalid JSON format in results.json!")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

def main() -> None:
  write_summary('test')
  write_summary('valid')

if __name__ == "__main__":
  main()