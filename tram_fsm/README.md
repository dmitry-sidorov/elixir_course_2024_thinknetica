# Homework 04

## Tram Finite State Machine (FSM)

The project is the implementation of tram [finite state machine](https://en.wikipedia.org/wiki/Finite-state_machine) on pure Elixir language according the following diagram:
![diagram](https://www.mermaidchart.com/raw/41c0536c-7c33-422c-a270-5e2faf5096cc?theme=light&version=v0.1&format=svg)

```renderAs=mermaid
flowchart TD
  In_depot ---> |move| Moving
  Moving ---> |move| In_depot
  Moving ---> |stop| On_station
  On_station ---> |move| Moving
  On_station ---> |doors| Onboarding_passengers
  Onboarding_passengers ---> |doors| On_station
  Moving ---> |blocked| Stopped
  Stopped ---> |unblocked| Moving 
  Moving ---> |red light| Stopped
  Stopped ---> |green light| Moving
  Moving ---> |bang| On_accident
  On_accident ---> |doors| Rescue_passengers
  Rescue_passengers --->|doors| On_accident
  On_accident ---> |move| Moving
  Moving ---> |repair| On_service
  On_service ---> |move| In_depot
```
