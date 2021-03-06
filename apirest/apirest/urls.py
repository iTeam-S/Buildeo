"""apirest URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/login/', views.login_view),
    path('api/permis/', views.getpermis_view),
    path('api/requestpermis/', views.requestpermis),
    path('api/userpermis/', views.get_userpermis_view),
    path('api/listcommune/', views.get_listcommune_view),
    path('api/listpermit/', views.get_listpermit_view),
    path('api/affectation/', views.affectation_view),
    path('download/attachement/<str:filename>', views.download_attachement),
    path('download/model/<str:filename>', views.download_model),
    path('api/updatestatus/', views.update_status),
    path('api/generatepermis/', views.generate_permis),
    path('api/generateqrcode/', views.generate_qrcode)
]
