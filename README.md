# Hoodie Weather

![road trip](https://info.oregon.aaa.com/wp-content/uploads/2020/06/PacificNWRoad_Banner.jpg)

<br>
Hoodie Weather is an API designed for road trip planning that enables users to anticipate the weather conditions in their destination city via a front-end application. To utilize this API, users must create an account and login to access its functionalities. After authentication, the API provides three endpoints to retrieve various types of information, including weather data for a specific city, road trip planning details, and salary information for a particular location.

<br>


Find Me On:

[![linkedin profile](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/axeldelaguardia)

Built With:

![Ruby 3.1.1](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)



---
## 3 Major Key Points for this Project

1. Retrieve Weather for a City
	- APIs Consumed: `Weather API` and `MapQuest Geocoding API`
	- The MapQuest API was used to get coordinates to provide to Weather API
	- The MapQuest API was also used to get ETA for road trip to destination

2. User Registration and Sessions
	- A POST endpoint is exposed to allow for user creation.
	- A response with the user email and an api key is returned.
	- If a user exists, the user can be authenticated and an api key can be returned in the response.

3. Road Trip Planning
	- A POST endpoint is exposed to plan ahead for a trip.
	- Trip information, including travel time, eta, weather at destination city are returned to the user
	- API key is required to get a response from this endpoint

---

## ENDPOINTS
### Forecast
<details>
  <summary>GET: Forecast for a City</summary>
  
  <br>
  Request:

  ```JS
  GET /api/v0/forecast
  ```
  
  Params: 

  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `location` | Required | string | city,st

  <br>

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 401 |


  ```JSON
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
</details>

<br>

### Create User
<details>
  <summary>POST /api/v0/users </summary>
  
  <br>
  Request:

  ```JS
  POST /api/v0/users
  ```
<br>

  Headers:
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `Content-Type` | Required | string | application/json
  | `Accept` | Required | string | application/json
	
<br>
	
  Body: 
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `email` | Required | string | valid email address
  | `password` | Required | string | matching password
  | `password confirmation` | Required | string | matching password

  <br>

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Failure`| 400 |


  ```JSON
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
</details>

<br>

### Login
<details>
  <summary>POST /api/v0/sessions </summary>
  
  <br>
  Request:

  ```JS
  POST /api/v0/session
  ```
<br>

  Headers:
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `Content-Type` | Required | string | application/json
  | `Accept` | Required | string | application/json
	
<br>
	
  Body: 
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `email` | Required | string | valid email address
  | `password` | Required | string | password associated to email

  <br>

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Bad Request`| 400 |


  ```JSON
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
</details>

<br>

### Road Trip
<details>
  <summary>POST /api/v0/road_trip </summary>
  
  <br>
  Request:

  ```JS
  POST /api/v0/road_trip
  ```
<br>

  Headers:
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `Content-Type` | Required | string | application/json
  | `Accept` | Required | string | application/json
	
<br>
	
  Body: 
  | Name | Requirement | Type | Description |
  | ----- | ----------- | -----| -------------- | 
  | `origin` | Required | string | city,st
  | `destination` | Required | string | city,st
  | `api_key` | Required | string | authorized api_key

  <br>

  Response: 

  | Result | Status |
  | ------- | ------| 
  | `Success` | 201 |
  | `Unauthorized`| 401 |


  ```JSON
	POST
	{
		"origin": "Cincinatti,OH",
		"destination": "Chicago,IL",
		"api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
	}

	RESPONSE
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
</details>