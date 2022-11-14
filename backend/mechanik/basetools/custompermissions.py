from rest_framework import permissions

class IsMechanicPermission(permissions.BasePermission):

    def has_permission(self, request, view):
        user_role = request.user.userinfo
        print(
            user_role.__dict__
        )
        if user_role == "M":
            return True
        return False