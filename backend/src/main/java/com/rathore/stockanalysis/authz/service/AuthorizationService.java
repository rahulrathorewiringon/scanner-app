package com.rathore.stockanalysis.authz.service;
public interface AuthorizationService { void requireScreenerAccess(String actorUserId,long screenerId,String requiredPermission); void requireWorkspacePresetAccess(String actorUserId,long presetId,String requiredPermission); boolean hasRole(String userId,String roleCode); }
