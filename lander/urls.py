from django.urls import path

from .views import HomeView, InvestorsView, InvestorSubmitView, DeckView

urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('investors/', InvestorsView.as_view(), name='investors'),
    path('investors/submit/', InvestorSubmitView.as_view(), name='investor-submit'),
    path('investors/deck/', DeckView.as_view(), name='deck'),
]
