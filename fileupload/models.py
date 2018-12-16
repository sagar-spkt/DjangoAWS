from django.db import models
from django.contrib.auth.models import User
from DjangoAWS.storage_backends import PrivateMediaStorage


# Create your models here.
class PublicDocument(models.Model):
    description = models.CharField(max_length=255, blank=True)
    document = models.FileField()
    uploaded_at = models.DateTimeField(auto_now_add=True)


class PrivateDocument(models.Model):
    description = models.CharField(max_length=255, blank=True)
    document = models.FileField(storage=PrivateMediaStorage())
    uploaded_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(User, related_name='documents', on_delete=models.DO_NOTHING)
