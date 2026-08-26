"""Tests for Gateway API routing configuration validation."""
import yaml
import os
import pytest

ROUTING_DIR = os.path.join(os.path.dirname(__file__), '..', 'routing')
MANIFESTS_DIR = os.path.join(os.path.dirname(__file__), '..')


def load_yaml_files(directory):
    files = {}
    for fname in os.listdir(directory):
        if fname.endswith('.yaml') or fname.endswith('.yml'):
            with open(os.path.join(directory, fname)) as f:
                files[fname] = list(yaml.safe_load_all(f))
    return files


def test_routing_yamls_are_valid():
    files = load_yaml_files(ROUTING_DIR)
    assert len(files) > 0, "No routing YAML files found"
    for fname, docs in files.items():
        for doc in docs:
            assert doc is not None, f"{fname}: empty document"
            assert "kind" in doc, f"{fname}: missing 'kind' field"


def test_canary_weights_sum_to_100():
    path = os.path.join(ROUTING_DIR, 'canary-90-10.yaml')
    with open(path) as f:
        doc = yaml.safe_load(f)
    rules = doc['spec']['rules']
    for rule in rules:
        backends = rule.get('backendRefs', [])
        if len(backends) > 1:
            total = sum(b.get('weight', 100) for b in backends)
            assert total == 100, f"Weights must sum to 100, got {total}"


def test_header_route_has_fallback():
    path = os.path.join(ROUTING_DIR, 'header-route.yaml')
    with open(path) as f:
        doc = yaml.safe_load(f)
    rules = doc['spec']['rules']
    # At least one rule without matches = default fallback
    fallback_rules = [r for r in rules if 'matches' not in r]
    assert len(fallback_rules) > 0, "Header route must have a fallback rule (no 'matches')"


def test_all_httproutes_have_parent_refs():
    files = load_yaml_files(ROUTING_DIR)
    for fname, docs in files.items():
        for doc in docs:
            if doc and doc.get('kind') == 'HTTPRoute':
                assert doc['spec'].get('parentRefs'), f"{fname}: HTTPRoute missing parentRefs"
