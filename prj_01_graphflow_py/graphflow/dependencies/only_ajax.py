from fastapi import Request, HTTPException

async def only_ajax(request: Request):
    if request.headers.get("X-Requested-With") != "XMLHttpRequest":
        raise HTTPException(
            status_code=403,
            detail="Accesso consentito solo tramite frontend"
        )