package gatewayapi.routes

deny[msg] {
    input.kind == "HTTPRoute"
    rule := input.spec.rules[_]
    backend := rule.backendRefs[_]
    not backend.port
    msg := "HTTPRoute backend references must explicitly define a port"
}

deny[msg] {
    input.kind == "HTTPRoute"
    not input.spec.parentRefs
    msg := "HTTPRoute must attach to a parent Gateway via parentRefs"
}
