from docxtpl import DocxTemplate
import qrcode

numero_permis = '1'

img = qrcode.make(numero_permis)
img.save("qr_new.png")

doc = DocxTemplate("template_permis.docx")
context = { 
     'commune' : 'Antananarivo',
     'nom_user': 'Angelo CRATOS',
     'build_type': 'une clôture de batiment de mur',
     'adresse': 'IV7JZ Ambatoroka',
     'date_validation': '20 Octobre 2021',
     'numero_permis': numero_permis
}
doc.replace_pic('qrcode.png', 'qr_new.png')

doc.render(context)
doc.save("generated_doc.docx")
