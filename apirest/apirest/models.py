from django.db import models
from django.contrib.auth.models import AbstractUser



class Province(models.Model):
    nom = models.CharField(max_length=50)

    def __str__(self):
        return self.nom


class Region(models.Model):
    nom = models.CharField(max_length=50)
    id_province = models.ForeignKey(Province, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom


class Disctrict(models.Model):
    nom = models.CharField(max_length=50)
    id_region = models.ForeignKey(Region, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom

class Commune(models.Model):
    nom = models.CharField(max_length=50)
    id_district = models.ForeignKey(Disctrict, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom

class User(AbstractUser, models.Model):
    cin = models.CharField(max_length=50, null=True)
    date_naissance = models.DateTimeField(default=None, blank=True, null=True)
    adress = models.CharField(max_length=400, default=None, blank=True, null=True)
    tel = models.CharField(max_length=13, default=None, blank=True, null=True)
    type = models.CharField(max_length=10, default=None, blank=True, null=True)
    commune_id = models.ForeignKey(Commune, default=None, blank=True, null=True, on_delete=models.CASCADE)


class Permis(models.Model):
    req_date = models.DateTimeField()
    req_user_id = models.ForeignKey(User, related_name='req_user_id', on_delete=models.CASCADE, default=None, blank=True, null=True)
    trtm_date = models.DateTimeField(default=None, blank=True, null=True)
    trtm_user_id = models.ForeignKey(User, related_name='trtm_user_id', on_delete=models.CASCADE, default=None, blank=True, null=True)
    status = models.CharField(max_length=50 ,choices=[
        ('ATTENTE_TRTM', 'Attente Traitement'),
        ('EN_TRTM', 'En traitement'),
        ('ATTENTE_VALIDATION', 'Attente Validation'),
        ('VALIDE', 'Validée')], default='ATTENTE_TRTM')
    attachements = models.CharField(max_length=300)
    motif_status = models.TextField(null=True, blank=True)
    build_adress = models.CharField(max_length=100)
    build_type = models.CharField(max_length=50)
    commune_id = models.ForeignKey(Commune, on_delete=models.CASCADE)
    delivery_date = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f'Permis-{self.id}'


class Historique(models.Model):
    date = models.DateTimeField()
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    action = models.CharField(max_length=100)
