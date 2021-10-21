from django.db import models
from django.contrib.auth.models import User

class Province(models.Model):
    nom = models.CharField(max_length=50)


class Region(models.Model):
    nom = models.CharField(max_length=50)
    id_province = models.ForeignKey(Province, on_delete=models.CASCADE)


class Disctrict(models.Model):
    nom = models.CharField(max_length=50)
    id_region = models.ForeignKey(Region, on_delete=models.CASCADE)


class Commune(models.Model):
    nom = models.CharField(max_length=50)
    id_district = models.ForeignKey(Disctrict, on_delete=models.CASCADE)


class Mponina(models.Model):
    nom = models.CharField(max_length=200)
    prenom = models.CharField(max_length=200)
    cin = models.IntegerField()
    date_naissance = models.DateTimeField()
    adress = models.CharField(max_length=400)


class Profil(models.Model):
    mponina_id = models.ForeignKey(Mponina, on_delete=models.CASCADE)
    tel = models.CharField(max_length=13)
    type = models.IntegerField()
    commune = models.CharField(max_length=50)
    user_id = models.OneToOneField(User, on_delete=models.CASCADE)


class Request(models.Model):
    req_date = models.DateTimeField()
    req_user_id = models.ForeignKey(Profil, related_name='req_user_id', on_delete=models.CASCADE)
    trtm_date = models.DateTimeField()
    trtm_user_id = models.ForeignKey(Profil, related_name='trtm_user_id', on_delete=models.CASCADE)
    status = models.CharField(max_length=50 ,choices=[
        ('ATTENTE_TRTM', 'Attente Traitement'),
        ('EN_TRTM', 'En traitement'),
        ('ATTENTE_VALIDATION', 'Attente Validation'),
        ('VALIDE', 'Validée')], default='ATTENTE_TRTM')
    attachements = models.CharField(max_length=300)
    motif_status = models.TextField()
    build_adress = models.CharField(max_length=100)
    build_type = models.CharField(max_length=50)
    commune_id = models.ForeignKey(Commune, on_delete=models.CASCADE)
    delivery_date = models.DateTimeField()


class Historique(models.Model):
    date = models.DateTimeField()
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    action = models.CharField(max_length=100)
