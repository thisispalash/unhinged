from django.http import HttpResponse
from django.shortcuts import redirect
from django.views import View
from django.views.generic import TemplateView

from .models import InvestorLead


class HomeView(TemplateView):
    template_name = 'pages/home.html'


class InvestorsView(TemplateView):
    template_name = 'pages/investors.html'


class InvestorSubmitView(View):
    """HTMX POST endpoint for investor email capture."""

    def post(self, request):
        name = request.POST.get('name', '').strip()
        email = request.POST.get('email', '').strip()

        if not name or not email:
            return HttpResponse(
                '<p class="text-red-500 mt-2">Please fill in all fields.</p>',
                status=400,
            )

        # Create or update the lead
        InvestorLead.objects.update_or_create(
            email=email,
            defaults={'name': name},
        )

        # Set session flag for deck access
        request.session['investor_verified'] = True

        # Return HTMX redirect to deck
        response = HttpResponse(status=200)
        response['HX-Redirect'] = '/investors/deck/'
        return response


class DeckView(TemplateView):
    template_name = 'pages/deck.html'

    def dispatch(self, request, *args, **kwargs):
        if not request.session.get('investor_verified'):
            return redirect('investors')
        return super().dispatch(request, *args, **kwargs)
