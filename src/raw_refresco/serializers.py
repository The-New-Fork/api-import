from rest_framework import serializers
from .models import RawRefresco, RawRefrescoIntegrity, TimestampTransaction
from django.core.validators import RegexValidator


class TimestampTransactionSerializer(serializers.ModelSerializer):

    txid = serializers.CharField(
        max_length=64,
        validators=[
            RegexValidator(
                regex='^.{64}$',
                message='Incorrect txid length, must be 64',
                code='txid64')])
    sender_raddress = serializers.CharField(
        max_length=34,
        validators=[
            RegexValidator(
                regex='^.{34}$',
                message='Incorrect raddress length, must be 34',
                code='raddress34')])

    class Meta:
        model = TimestampTransaction
        fields = ('id', 'sender_raddress', 'sender_name', 'tsintegrity', 'txid')


class RawRefrescoIntegritySerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(read_only=True)
    tx_list = TimestampTransactionSerializer(many=True, read_only=True)

    class Meta:
        model = RawRefrescoIntegrity
        fields = ('id', 'integrity_address', 'integrity_pre_tx', 'integrity_post_tx', 'batch', 'tx_list', 'batch_lot_raddress')


class RawRefrescoSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(read_only=True)
    integrity_details = RawRefrescoIntegritySerializer(read_only=True)

    class Meta:
        model = RawRefresco
        fields = ('id', 'anfp', 'dfp', 'bnfp', 'pds', 'pde', 'jds', 'jde', 'bbd', 'pc', 'pl', 'rmn', 'pon', 'pop', 'raw_json', 'integrity_details')
