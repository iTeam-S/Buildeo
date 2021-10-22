from .models import Commune, Permis, User
import jwt
import json
from os import environ
from datetime import datetime, timedelta
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate
from django.http import JsonResponse, Http404


def encode_auth_token(user_id):
	payload = {
		'exp': datetime.utcnow() + timedelta(days=7),
		'sub': user_id
	}
	return jwt.encode(
		payload,
		environ.get('TOKEN_KEY'),
		algorithm='HS256'
	)


def verif_token(fonction):
        def trt_verif(*arg, **kwarg):
            try:
                data = json.loads(arg[0].body.decode("utf-8"))
                user_id, token = data['user_id'], data['token']
                assert user_id == jwt.decode(token, environ.get('TOKEN_KEY'), algorithms='HS256', options={"verify_signature": True})['sub']
            except Exception as err:
                print(err)
                return JsonResponse({'status_code': 403, 'status': 'INVALID_TOKEN', 'data': None})
            return fonction(*arg, **kwarg)
        return trt_verif


@csrf_exempt
def login_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        usr = data.get('usr')
        passwd = data.get('passwd')
        if '@' in usr:
            user = User.objects.filter(email=usr)
            if not user:
                return JsonResponse({'status_code': 403, 'status': 'AUTH_FAILED', 'data': None})
        else:
            user = User.objects.filter(email=usr)
            if not user:  # Si l'objet renvoyé n'est pas None
                return JsonResponse({'status_code': 403, 'status': 'AUTH_FAILED', 'data': None})
        user = authenticate(username=user[0].username, password=passwd)
        if not user:
            return JsonResponse({'status_code': 403, 'status': 'AUTH_FAILED', 'data': None})
        return JsonResponse(
            {
                'status_code' : 200, 'status': 'OK',
                'data' : {
                    'token' : encode_auth_token(user.id),
                    'user_id': user.id,
                    'compte': user.type
                }
            }
        )
    return Http404()


@csrf_exempt
def getpermis_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        numero_permis = data.get('numero_permis')
        if not numero_permis:
            return JsonResponse({'status_code': 404, 'status': 'MISSING numero_permis', 'data': None})
        try:
            permis = Permis.objects.get(id=numero_permis, status='VALIDE')
            commune = Commune.objects.get(id=permis.commune_id_id)
            return JsonResponse({
                'status_code': 200,
                'status': 'OK',
                'data': {
                    'numero_permis': f"Permis de Construire n°{permis.id}/{permis.delivery_date.strftime('%y')}/{commune.nom}",
                    'id': permis.id,
                    'demande': permis.build_type,
                    'delivery_date': permis.delivery_date.strftime('%Y-%m-%d'),
                    'adress': permis.build_adress
                }
            }, safe=False, json_dumps_params={'ensure_ascii': False})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'PERMIS_INNEXISTANT', 'data': None})
    return Http404()


