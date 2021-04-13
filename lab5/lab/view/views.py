from django.http import HttpResponse

def index(request):
    return HttpResponse("Куда мы без UNIX?")
