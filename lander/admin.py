from django.contrib import admin

from .models import InvestorLead


@admin.register(InvestorLead)
class InvestorLeadAdmin(admin.ModelAdmin):
    list_display = ('name', 'email', 'created_at')
    search_fields = ('name', 'email')
    readonly_fields = ('created_at',)
