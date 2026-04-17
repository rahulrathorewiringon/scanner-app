package com.rathore.stockanalysis.authz.dto;

public final class AuthorizationDtos {
    private AuthorizationDtos() {}

    public record UpdateSharePermissionRequestDto(
            String actorUserId,
            String sharedWithUserId,
            String permissionCode
    ) {}
}
