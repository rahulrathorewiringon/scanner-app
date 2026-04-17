package com.rathore.stockanalysis.authz.service.impl;

import com.rathore.stockanalysis.authz.service.AuthorizationService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class AuthorizationServiceImpl implements AuthorizationService {
    private final JdbcTemplate jdbcTemplate;
    public AuthorizationServiceImpl(JdbcTemplate jdbcTemplate) { this.jdbcTemplate = jdbcTemplate; }
    public void requireScreenerAccess(String actorUserId,long screenerId,String requiredPermission){ Integer owner=jdbcTemplate.queryForObject("select count(*) from app_ui.saved_screener_definition where screener_id=? and user_id=?",Integer.class,screenerId,actorUserId); if(owner!=null&&owner>0)return; Integer share=jdbcTemplate.queryForObject("select count(*) from app_ui.saved_screener_share where screener_id=? and shared_with_user_id=? and permission_code in (?, 'EDIT')",Integer.class,screenerId,actorUserId,requiredPermission); if(share!=null&&share>0)return; if(hasRole(actorUserId,"ADMIN"))return; throw new IllegalStateException("User does not have required screener permission"); }
    public void requireWorkspacePresetAccess(String actorUserId,long presetId,String requiredPermission){ Integer owner=jdbcTemplate.queryForObject("select count(*) from app_ui.workspace_layout_preset where preset_id=? and user_id=?",Integer.class,presetId,actorUserId); if(owner!=null&&owner>0)return; Integer share=jdbcTemplate.queryForObject("select count(*) from app_ui.workspace_layout_preset_share where preset_id=? and shared_with_user_id=? and permission_code in (?, 'EDIT')",Integer.class,presetId,actorUserId,requiredPermission); if(share!=null&&share>0)return; if(hasRole(actorUserId,"ADMIN"))return; throw new IllegalStateException("User does not have required workspace preset permission"); }
    public boolean hasRole(String userId,String roleCode){ Integer c=jdbcTemplate.queryForObject("select count(*) from app_ui.user_role_assignment where user_id=? and role_code=?",Integer.class,userId,roleCode); return c!=null&&c>0; }
}
