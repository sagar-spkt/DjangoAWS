from django.urls import path
from fileupload import views

app_name = 'fileupload'

urlpatterns = [
    path('', views.home, name='home'),
]
