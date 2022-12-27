from rest_framework import permissions

class IsMechanicPermission(permissions.BasePermission):

    def has_permission(self, request, view):
        user = request.user

        user_role = user.userinfo.role
        if user_role == "M":
            return True
        return False