from rest_framework import generics
from rest_framework import viewsets
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.validators import ValidationError
from rest_framework.permissions import IsAuthenticated
from rest_framework import mixins
from userinfo.models import UserInfo
from userinfo.serializer import UserInfoSerializer

from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission

from random  import randint

class UserInfoViewSet(viewsets.ModelViewSet):
    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class MyUserInfo(viewsets.GenericViewSet):
    """
    Show info about logged in user
    description:
        Return info about logged in user like: name, surname,
        phone_number, email, avatar
    """


    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

    def get_queryset(self):

        user = self.request.user

        userinfo = UserInfo.objects.filter(user=user).first()

        if not userinfo:
            raise NotFound
        
        return userinfo

    def list(self,*args, **kwargs):
        userinfo = self.get_queryset()
        serializered_userinfo = self.get_serializer(userinfo,many=False)

        return Response(serializered_userinfo.data)




class GenerateCode(APIView):


    def send_an_email(self):

        return

    def post(self,request,format=None):
        """
        description:
            Generated code, which is sent to email
        :description
        body:
            - email<->required<->
        :body
        """
        # return Response(request.data)
        try:
            email = request.data['email']
        except:
            raise ValidationError("Email nie został podany!")


        code_length  = 5 # cannot be longer than code in GeneratedCode model!!
        code = "".join(str(randint(0,9)) for i in range(code_length))
        if UserInfo.objects.filter(email=email).first():
            print()
        else:
            raise NotFound("Brak takiego emaila")

        return Response(code)

    schema = MyOwnSchema(description=post.__doc__)


