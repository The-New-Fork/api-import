from rest_framework import serializers
from .models import RawRefresco, RawRefrescoIntegrity


class RawRefrescoIntegritySerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(read_only=True)

    class Meta:
        model = RawRefrescoIntegrity
        fields = ('id', 'integrity_address', 'integrity_pre_tx', 'integrity_post_tx', 'batch')


class RawRefrescoSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(read_only=True)
    integrity_details = RawRefrescoIntegritySerializer(read_only=True)

    class Meta:
        model = RawRefresco
        fields = ('id', 'anfp', 'dfp', 'bnfp', 'pds', 'pde', 'jds', 'jde', 'bbd', 'pc', 'pl', 'rmn', 'pon', 'pop', 'raw_json', 'integrity_details')