from fastapi.responses import HTMLResponse
from fastapi import HTTPException, status
from fastapi.security import  OAuth2PasswordBearer
from fastapi import Depends, Security
from sqlalchemy.orm import Session
from database.database import get_db
from repositories.token_dao import TokenDAO
from repositories.utente_dao import UtenteDAO
from services.token_service import TokenService
from security.security import verify_password, hash_password

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/signin") # recupera il token dall'header (Authorization: Bearer <token>)

def admin_required(
    token: str = Security(oauth2_scheme),
    db: Session = Depends(get_db)
):
    token_service = TokenService(db)
    utente = token_service.token_validation(token)
    print(utente.Is_Admin)
    if utente.Is_Admin == 'N':
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Accesso negato: privilegi amministrativi richiesti"
        )
    return utente

#Torna utente se il suo token esiste e non è scaduto
def get_current_user(
    token: str = Security(oauth2_scheme),
    db: Session = Depends(get_db)
):
    token_service = TokenService(db)
    utente = token_service.token_validation(token)
    if not utente:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token non valido o utente non autenticato"
        )
    return utente

class AuthService:
    def __init__(self, db: Session):
        self.utente_dao = UtenteDAO(db)
        self.token_dao = TokenDAO(db)

    def create_user(self, email: str, password: str):
        return self.utente_dao.create(email, hash_password(password))
    
    def authenticate_user(self, email: str, password: str):
        utente = self.utente_dao.get_by_email(email)
        if not utente or not verify_password(password, utente.Password):
            return None
        return utente