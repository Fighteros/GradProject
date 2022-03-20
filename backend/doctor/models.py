from django.db import models


# Create your models here.

class Doctor(models.Model):
    username = models.CharField(primary_key=True, max_length=255)
    first_name = models.CharField(max_length=255, null=False)
    last_name = models.CharField(max_length=255, null=False)
    email = models.CharField(max_length=255, null=False, unique=True)
