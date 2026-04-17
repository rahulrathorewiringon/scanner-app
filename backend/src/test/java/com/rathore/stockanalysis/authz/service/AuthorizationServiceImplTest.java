package com.rathore.stockanalysis.authz.service;

import com.rathore.stockanalysis.authz.service.impl.AuthorizationServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class AuthorizationServiceImplTest {

    @Test
    void shouldAllowOwnerAccess() {
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.saved_screener_definition"), eq(Integer.class), anyLong(), anyString()))
                .thenReturn(1);
        AuthorizationServiceImpl service = new AuthorizationServiceImpl(jdbcTemplate);
        assertDoesNotThrow(() -> service.requireScreenerAccess("owner", 10L, "VIEW"));
    }

    @Test
    void shouldAllowAdminRoleFallback() {
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.saved_screener_definition"), eq(Integer.class), anyLong(), anyString()))
                .thenReturn(0);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.saved_screener_share"), eq(Integer.class), anyLong(), anyString(), anyString()))
                .thenReturn(0);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.user_role_assignment"), eq(Integer.class), anyString(), anyString()))
                .thenReturn(1);
        AuthorizationServiceImpl service = new AuthorizationServiceImpl(jdbcTemplate);
        assertDoesNotThrow(() -> service.requireWorkspacePresetAccess("adminUser", 11L, "EDIT"));
    }

    @Test
    void shouldRejectUnauthorizedUser() {
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.workspace_layout_preset"), eq(Integer.class), anyLong(), anyString()))
                .thenReturn(0);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.workspace_layout_preset_share"), eq(Integer.class), anyLong(), anyString(), anyString()))
                .thenReturn(0);
        when(jdbcTemplate.queryForObject(startsWith("select count(*) from app_ui.user_role_assignment"), eq(Integer.class), anyString(), anyString()))
                .thenReturn(0);
        AuthorizationServiceImpl service = new AuthorizationServiceImpl(jdbcTemplate);
        assertThrows(IllegalStateException.class, () -> service.requireWorkspacePresetAccess("viewer", 11L, "EDIT"));
    }
}
