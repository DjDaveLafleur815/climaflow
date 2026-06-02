from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import weather

app = FastAPI(
    title="ClimaFlow API",
    description="API Météo pour l'application Flutter",
    version="1.0.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Inclusion des routers
app.include_router(weather.router, prefix="/api", tags=["weather"])

@app.get("/")
async def root():
    return {
        "message": "✅ ClimaFlow API is running!",
        "status": "ok",
        "docs": "/docs"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)
