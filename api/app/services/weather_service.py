import httpx
from dotenv import load_dotenv
import os
from typing import Dict, Any

load_dotenv()

class WeatherService:
    BASE_URL = "https://api.openweathermap.org/data/2.5"
    
    def __init__(self):
        self.api_key = os.getenv("OPENWEATHER_API_KEY")
        print("="*60)
        print(f"🔑 CLÉ API → {self.api_key[:15]}... (longueur: {len(self.api_key) if self.api_key else 0})")
        print("="*60)
    
    async def get_current_weather(self, city: str) -> Dict[str, Any]:
        if not self.api_key:
            raise ValueError("Clé API manquante")
            
        async with httpx.AsyncClient(timeout=10.0) as client:
            response = await client.get(
                f"{self.BASE_URL}/weather",
                params={
                    "q": city,
                    "appid": self.api_key,
                    "units": "metric",
                    "lang": "fr"
                }
            )
            print(f"🌤️ Status OpenWeather: {response.status_code} pour {city}")
            response.raise_for_status()
            return response.json()
    
    async def get_forecast(self, city: str) -> Dict[str, Any]:
        async with httpx.AsyncClient(timeout=10.0) as client:
            response = await client.get(
                f"{self.BASE_URL}/forecast",
                params={
                    "q": city,
                    "appid": self.api_key,
                    "units": "metric",
                    "lang": "fr"
                }
            )
            response.raise_for_status()
            return response.json()
