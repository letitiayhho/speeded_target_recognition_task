function out = isWindowsAdmin()
    %ISWINDOWSADMIN True if this user is in admin role.
    wi = System.Security.Principal.WindowsIdentity.GetCurrent();
    wp = System.Security.Principal.WindowsPrincipal(wi);
    out = wp.IsInRole(System.Security.Principal.WindowsBuiltInRole.Administrator);
    if ~out
        error('Please quit MATLAB and run this script with Admin privileges')
    end
end