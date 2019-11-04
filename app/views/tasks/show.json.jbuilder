# json.partial! "tasks/task", task: @task
json.title @task.title
json.content @task.content
json.username @task.user.name
json.start @task.start_date
json.end @task.end_date