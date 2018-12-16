from django.contrib import admin
from fileupload.models import PublicDocument, PrivateDocument

# Register your models here.
admin.site.register(PublicDocument)
admin.site.register(PrivateDocument)
