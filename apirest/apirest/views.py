from .models import Commune, Permis, User
import jwt
import json
import time
import mimetypes
from os import environ
from datetime import datetime
from datetime import datetime, timedelta
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate
from django.http import JsonResponse, Http404, HttpResponse
from werkzeug.utils import secure_filename
from django.core.files.storage import FileSystemStorage


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
                    'compte': user.type,
                    'nom': f'{user.first_name} {user.last_name}',
                    'email': usr,
                    'commune_id' : user.commune_id.id
                }
            }
        )
    return Http404


@csrf_exempt
def getpermis_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        numero_permis = data.get('numero_permis')
        if not numero_permis:
            return JsonResponse({'status_code': 404, 'status': 'MISSING_NUM_PERMIS', 'data': None})
        try:
            permis = Permis.objects.get(id=numero_permis, status='VALIDE')
            commune = Commune.objects.get(id=permis.commune_id_id)
            return JsonResponse({
                'status_code': 200,
                'status': 'OK',
                'data': {
                    'numero_permis': f"Permis de Construire n°{permis.id}/{permis.delivery_date}/{commune.nom}",
                    'id': permis.id,
                    'demande': permis.build_type,
                    'delivery_date': permis.delivery_date,
                    'adress': permis.build_adress
                }
            }, safe=False, json_dumps_params={'ensure_ascii': False})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'PERMIS_INNEXISTANT', 'data': None})
    return Http404


@csrf_exempt
@verif_token
def get_userpermis_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        user_id = data.get('user_id')
        if not user_id:
            return JsonResponse({'status_code': 404, 'status': 'MISSING_USERID', 'data': None})
        try:
            permis = Permis.objects.filter(req_user_id = user_id)
            list_permi = []
            for permi in permis:
                permi = dict(permi.__dict__)
                permi.pop('_state')
                list_permi.append(permi)
            return JsonResponse({'status_code': 200, 'status': 'OK', 'data': list_permi})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'PERMIS INNEXISTANT', 'data': None})
    return Http404


@csrf_exempt
def requestpermis(request):
    if request.method == "POST":
        token = request.POST.get('token')
        try:
            jwt.decode(token, environ.get('TOKEN_KEY'), algorithms='HS256', options={"verify_signature": True})['sub']
        except Exception as err:
            return JsonResponse({'status_code': 404, 'status': 'INVALID_TOKEN', 'data': None})
        
        req_date = datetime.today()
        attachement = request.FILES.get('file')
        req_user_id = int(request.POST.get('user_id'))
        req_user_id = User.objects.get(id=req_user_id)
        commune_id = int(request.POST.get('commune_id'))
        commune_id = Commune.objects.get(id=commune_id)
        build_type = request.POST.get('build_type')
        build_adress = request.POST.get('build_adress')

        if not attachement :
            return JsonResponse({'status_code': 404, 'status': 'MISSING_ATTACHEMENT', 'data': None})
        try:
            filename = str(time.time()) + '_' + secure_filename(attachement.name)
            fss = FileSystemStorage(location='media/attachement/')
            file = fss.save(filename, attachement)

            Permis.objects.create(
                req_date=req_date, 
                build_type=build_type,
                commune_id=commune_id,
                req_user_id=req_user_id,
                attachements=filename,
                build_adress=build_adress,
            )
            return JsonResponse({'status_code': 200, 'status': 'DEMANDE_ENVOYE', 'data': None})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'PERMIS_INNEXISTANT', 'data': None})
    return Http404


@csrf_exempt
def get_listcommune_view(request):
    try:
        communes = Commune.objects.all()
        return JsonResponse({'status_code': 200, 'status': 'OK', 'data': [{"id":commune.id,"nom":commune.nom} for commune in communes]})
    except Exception as err:
        print(err)
        return JsonResponse({'status_code': 404, 'status': 'ERREUR', 'data': None})


@csrf_exempt
def get_listpermit_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        commune_id = data.get("commune_id")
        if not commune_id:
            return JsonResponse({'status_code': 404, 'status': 'MISSING_COMMUNE_ID', 'data': None})
        try:
            permis = Permis.objects.filter(commune_id=commune_id).order_by("-id")[:20]
            list_permi = []
            for permi in permis:
                permi = dict(permi.__dict__)
                permi['req_date'] = permi['req_date'].strftime('%Y-%m-%d %H:%M:%S')
                if permi['trtm_date']: permi['trtm_date'] = permi['trtm_date'].strftime('%Y-%m-%d %H:%M:%S')
                if permi['delivery_date']: permi['delivery_date'] = permi['delivery_date'].strftime('%Y-%m-%d %H:%M:%S')
                permi.pop('_state')
                list_permi.append(permi)
                print(list_permi)
            return JsonResponse({'status_code': 200, 'status': 'OK', 'data': list_permi})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'ERREUR', 'data': None})
    return Http404


@csrf_exempt
@verif_token
def affectation_view(request):
    if request.method == "POST":
        data = json.loads(request.body.decode("utf-8"))
        trtm_user_id = data.get("trtm_user_id")
        permis_id = data.get("permis_id")
        if not trtm_user_id:
            return JsonResponse({'status_code': 404, 'status': 'MISSING_USERID', 'data': None})
        if not permis_id:
            return JsonResponse({'status_code': 404, 'status': 'MISSING_PERMISID', 'data': None})
        try:
            Permis.objects.filter(id=permis_id).update(trtm_user_id=trtm_user_id,status='EN_TRTM',trtm_date=datetime.today())
            permi = Permis.objects.get(id=permis_id).__dict__
            permi.pop("_state")
            return JsonResponse({'status_code': 200, 'status': 'OK', 'data': permi})
        except Exception as err:
            print(err)
            return JsonResponse({'status_code': 404, 'status': 'ERREUR', 'data': None})
    return Http404


@csrf_exempt
def download_attachement(request, filename):
    fl = open('media/attachement/'+filename, 'rb')
    token = request.GET.get("token")
    try:
        jwt.decode(token, environ.get('TOKEN_KEY'), algorithms='HS256', options={"verify_signature": True})['sub']
    except Exception as err:
        return JsonResponse({'status_code': 404, 'status': 'INVALID_TOKEN', 'data': None})

    try:
        mime_type, _ = mimetypes.guess_type('media/'+filename)
        response = HttpResponse(fl, content_type=mime_type)
        response['Content-Disposition'] = "attachment; filename=%s" % filename
        return response
    except Exception as err:
        print(err)
        return JsonResponse({'status_code': 404, 'status': 'ERREUR', 'data': None})

@csrf_exempt
def download_model(request, filename):
    try:
        fl = open('media/model/'+filename, 'rb')
        mime_type, _ = mimetypes.guess_type('media/'+filename)
        response = HttpResponse(fl, content_type=mime_type)
        response['Content-Disposition'] = "attachment; filename=%s" % filename
        return response
    except Exception as err:
        print(err)
        return JsonResponse({'status_code': 404, 'status': 'ERREUR', 'data': None})
