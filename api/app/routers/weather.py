from fastapi import APIRouter, HTTPException, Query
from app.services.weather_service import WeatherService

router = APIRouter()

weather_service = WeatherService()

@router.get("/weather/{city}")
async def get_weather(city: str):
    """Récupère la météo actuelle d'une ville"""
    try:
        data = await weather_service.get_current_weather(city)
        return {
            "city": data["name"],
            "country": data["sys"]["country"],
            "temperature": round(data["main"]["temp"]),
            "feels_like": round(data["main"]["feels_like"]),
            "description": data["weather"][0]["description"].capitalize(),
            "humidity": data["main"]["humidity"],
            "wind_speed": data["wind"]["speed"],
            "pressure": data["main"]["pressure"],
            "icon": data["weather"][0]["icon"],
            "coordinates": {
                "lat": data["coord"]["lat"],
                "lon": data["coord"]["lon"]
            }
        }
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"Ville non trouvée ou erreur API: {str(e)}")


@router.get("/forecast/{city}")
async def get_forecast(city: str):
    """Récupère les prévisions sur 5 jours"""
    try:
        data = await weather_service.get_forecast(city)
        return data
    except Exception as e:
        raise HTTPException(status_code=404, detail=str(e))


@router.get("/weather/coords")
async def get_weather_by_coords(
    lat: float = Query(..., description="Latitude"),
    lon: float = Query(..., description="Longitude")
):
    """Récupère la météo par coordonnées GPS"""
    try:
        data = await weather_service.get_weather_by_coords(lat, lon)
        return data
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
