from django.shortcuts import render
# from django.views.generic.edit import CreateView
# from django.urls import reverse_lazy
#
# from .models import PublicDocument, PrivateDocument


# Create your views here.
def home(request):
    return render(request, 'fileupload/home.html')


# class PublicDocumentCreateView(CreateView):
#     model = PublicDocument
#     fields = ['description', 'document', ]
#     success_url = reverse_lazy('fileupload:home')
#     template_name = 'fileupload/document_form.html'
#
#     def get_context_data(self, **kwargs):
#         context = super().get_context_data(**kwargs)
#         documents = PublicDocument.objects.all()
#         context['documents'] = documents
#         return context

