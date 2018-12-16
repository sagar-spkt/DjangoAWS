from django import forms
from fileupload.models import PublicDocument


class DocumentForm(forms.ModelForm):
    class Meta:
        model = PublicDocument
        fields = ('description', 'document')
