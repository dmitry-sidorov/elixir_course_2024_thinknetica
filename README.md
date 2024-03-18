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
  In_depot ---> |move| Moving
  Moving ---> |stop| In_depot
  Moving ---> |stop| Onboarding
  Onboarding ---> |move| Moving
  Moving ---> |block| Blocked
  Blocked ---> |block| Moving
  Moving ---> |stop| On_red_light_stop
  On_red_light_stop ---> |move| Moving
  Moving ---> |bang| On_accident
  On_accident ---> |doors| Rescue_passengers
  Rescue_passengers --->|doors| On_accident
  On_accident ---> |move| Moving
  Moving ---> |repair| On_service
  On_service ---> |move| In_depot
```
