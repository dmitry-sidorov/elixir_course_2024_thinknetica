# Repository with homework/projects for the Elixir course from Aleksei Matiushkin (Thinknetica)

 - Lector: https://github.com/am-kantox
 - Course: https://thinknetica.com/pro/elixir_phoenix

## Homework 01
 - Create a simple project from scratch, like a calculator. [Chmod calculator](https://github.com/dmitry-sidorov/elixir_course_2024_thinknetica/tree/homework_01/create-mix-project/project_one)
 - Make tests and documentation for the project.
 - Solve some katas on exircism.io. [See exircism profile](https://exercism.org/profiles/dmitry-sidorov/solutions?track_slug=elixir)

## Homework 02
 - Write an echo module, which recieves :ping atom as a message and returns {:pong, node()} tuple.
 - Write unit tests.
 
## Homework 04
 The project is the implementation of tram [finite state machine](https://en.wikipedia.org/wiki/Finite-state_machine) on pure Elixir language according the following diagram:

```renderAs=mermaid
flowchart TD
  Depot ---> |start the route| Move_to_station
  Move_to_station ---> |finish the route| Depot
  Move_to_station ---> |arrive to station| Stop_on_station
  Stop_on_station ---> |moving to next station| Move_to_station
  Stop_on_station ---> |open the doors| Doors_opened
  Doors_opened ---> |close the doors|Stop_on_station
  Doors_opened ---> |start onboarding passengers| Onboarding_passengers
  Onboarding_passengers ---> |stop onboarding passengers| Doors_opened
  Move_to_station ---> |railway_blocked| Stop_by_railway_block
  Stop_by_railway_block ---> |continue the route| Move_to_station
  Move_to_station ---> |traffic light red| Stop_by_traffic_light
  Stop_by_traffic_light ---> |traffic light green| Move_to_station
  Move_to_station ---> |unexpected accident happened| Stop_by_accident
  Stop_by_accident ---> |open the doors| Emergency_doors_opening
  Emergency_doors_opening --->|start rescue passengers| Rescue_passengers
  Rescue_passengers ---> |stop rescue passengers| Emergency_doors_opening
  Emergency_doors_opening ---> |close the doors| Stop_by_accident
  Stop_by_accident ---> |move to service station| Service
  Service ---> |back to depot| Depot
```