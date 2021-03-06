from rest_framework import viewsets
from .models import RawRefresco, RawRefrescoIntegrity, TimestampTransaction
from .serializers import RawRefrescoSerializer, RawRefrescoIntegritySerializer, TimestampTransactionSerializer
# from rest_framework.views import APIView
# from rest_framework.mixins import ListModelMixin, RetrieveModelMixin
from rest_framework.decorators import action
from rest_framework.response import Response


class RawRefrescoIntegrityView(viewsets.ModelViewSet):
    queryset = RawRefrescoIntegrity.objects.all()
    serializer_class = RawRefrescoIntegritySerializer


class TimestampTransactionView(viewsets.ModelViewSet):
    queryset = TimestampTransaction.objects.all()
    serializer_class = TimestampTransactionSerializer


class RawRefrescoView(viewsets.ModelViewSet):
    queryset = RawRefresco.objects.all()
    serializer_class = RawRefrescoSerializer

    # from https://stackoverflow.com/a/23836288
    # from https://www.django-rest-framework.org/api-guide/viewsets/
    # #marking-extra-actions-for-routing
    @action(detail=False)  # listview
    def require_integrity(self, request, pk=None):
        null_integrity = RawRefresco.objects.filter(
            integrity_details__isnull=True
        )
        serializer = self.get_serializer(null_integrity, many=True)
        return Response(serializer.data)
