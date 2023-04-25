# Hoodie Weather

JSON Contract:

```
Weather Request

GET
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
				"last_updated": "2023-04-07 16:30",
				"temperature": "72.5",
				"feels_like": "73.3",
				"humidity": "38.2",
				"uvi": "4.5",
				"visibility": "10.0",
				"condition": "cloudy with a chance of meatballs",
				"icon": "image.png"
      },
      "daily_weather": [
        {
					"date": "2023-04-07",
					"sunrise": "07:13 AM",
					"sunset": "08:07 AM",
					"max_temp": "76.7",
					"min_temp": "56.3",
					"condition": "sunny and warm",
					"icon": "image.png"
        },
        {...} etc
      ],
      "hourly_weather": [
        {
					"time": "22:00",
					"temperature": "75.5",
					"conditions": "nice and warm",
					"icon": "image.png"
        },
        {...} etc
      ]
    }
  }
}
```
```
User Creation

POST
{
	"email": "whatever@example.com",
	"password": "password",
	"password_confirmation": "password"
}

RESPONSE
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
```
Login

POST
{
	"email": "whatever@example.com",
	"password": "password"
}

RESPONSE
{
	"data": {
		"type": "users",
		"id": "1",
		"attributes": {
			"email": "whatever@example.com",
			"api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
		}
	}
}
```
```
Road Trip

POST 
body:
{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}

{
	"data": {
		"id": "null",
		"type": "road_trip",
		"attributes": {
			"start_city": "Cincinatti, OH",
			"end_city": "Chicago, IL",
			"travel_time": "04:40:45",
			"weather_at_eta": {
				"datetime": "2023-04-07 23:00",
				"temperature": 44.2,
				"condition": "Cloudy with a chance of meatballs"
			}
		}
	}
}
```
---
## 3 Major Key Points for this Project

1. Retrieve Weather for a City
APIs Consumed:
MapQuest's Geocoding API
- Used to retrieve the latitude and longitude for the city.
Weather API
- Used in conjunction with MapQuest to use the latitude and longitude to retrieve forecast.

2. User Registration
- A POST endpoint is exposed to allow for user creation.
- A response with the user email and an api key is returned.





## ENDPOINTS
### Forecast
<summary>GET: Forecast for a City</summary>

```GET "/api/v0/forecast?location=< CITY,ST >" - to retrieve weather data```
```POST "/api/v0/users" - to create a user and receive an API key```
POST "/api/v0/sessions"
POST "/api/v0/road_trip"