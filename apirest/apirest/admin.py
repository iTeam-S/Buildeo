from django.contrib import admin

from .models import *

admin.site.register(
    [Province,Region,Disctrict,
    Commune,Mponina,Profil,
    Request,Historique])