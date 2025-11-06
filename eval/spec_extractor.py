#!/usr/bin/env python3
"""
Modular Dafny specification extractor and validator.
"""

import re
from typing import Dict, List, Tuple, Optional, Any


class TextCleaner:
    """Handle text cleaning operations"""
    
    @staticmethod
    def remove_comments(text: str) -> str:
        """Remove inline comments from text"""
        return re.sub(r'//.*$', '', text)
    
    @staticmethod
    def remove_trailing_braces(text: str) -> str:
        """Remove trailing {} or { from text"""
        return re.sub(r'\s*\{}?\s*$', '', text)
    
    @staticmethod
    def clean_clause(text: str) -> str:
        """Clean a clause by removing comments and braces"""
        text = TextCleaner.remove_comments(text)
        text = TextCleaner.remove_trailing_braces(text)
        return text.strip()


class DeclarationDetector:
    """Detect Dafny declarations in code"""
    
    DECLARATION_TYPES = ['method', 'function', 'lemma', 'predicate', 'datatype']
    
    @staticmethod
    def detect_declaration(line: str) -> Optional[Tuple[str, str]]:
        """Detect declaration type and name from a line"""
        for decl_type in DeclarationDetector.DECLARATION_TYPES:
            match = re.match(rf'{decl_type}\s+(\w+)', line)
            if match:
                return (decl_type, match.group(1))
        return None


class BlockExtractor:
    """Extract code blocks for declarations"""
    
    @staticmethod
    def extract_block(lines: List[str], start_idx: int) -> Tuple[List[str], int]:
        """Extract a complete declaration block"""
        block = [lines[start_idx]]
        i = start_idx + 1
        
        while i < len(lines):
            line = lines[i].strip()
            
            # Stop at next declaration
            if DeclarationDetector.detect_declaration(line):
                break
            
            # Stop at body or Test method
            if line.startswith('method Test(') or line.startswith('{') or line == '{}':
                break
            
            block.append(lines[i])
            i += 1
        
        return block, i


class ContractParser:
    """Parse contract clauses from code blocks"""
    
    CONTRACT_KEYWORDS = ['requires', 'ensures', 'modifies']
    
    @staticmethod
    def parse_contracts(block: List[str]) -> Dict[str, List[str]]:
        """Parse all contract clauses from a block"""
        contracts = {'requires': [], 'ensures': [], 'modifies': []}
        
        current_clause = None
        current_content = []
        
        for line in block[1:]:
            stripped = line.strip()
            if not stripped or stripped.startswith('//'):
                continue
            
            # Check if line starts a new clause
            new_clause = None
            for keyword in ContractParser.CONTRACT_KEYWORDS:
                if stripped.startswith(keyword):
                    new_clause = keyword
                    break
            
            if new_clause:
                # Save previous clause
                if current_clause:
                    ContractParser._add_clause(current_clause, current_content, contracts)
                current_clause = new_clause
                current_content = [stripped]
            elif current_clause and stripped:
                current_content.append(stripped)
        
        # Add last clause
        if current_clause:
            ContractParser._add_clause(current_clause, current_content, contracts)
        
        return contracts
    
    @staticmethod
    def _add_clause(clause_type: str, content: List[str], contracts: Dict[str, List[str]]):
        """Add a cleaned clause to contracts"""
        clause_text = ' '.join(content)
        clause_text = TextCleaner.clean_clause(clause_text)
        if clause_type in contracts:
            contracts[clause_type].append(clause_text)


class SpecBuilder:
    """Build specification dictionaries"""
    
    @staticmethod
    def build_spec(name: str, signature: str, contracts: Dict[str, List[str]], 
                   full_block: List[str]) -> Dict[str, Any]:
        """Build a specification dictionary"""
        return {
            'name': name,
            'signature': signature,
            'requires': contracts.get('requires', []),
            'ensures': contracts.get('ensures', []),
            'modifies': contracts.get('modifies', []),
            'full_spec': '\n'.join(full_block)
        }


class DafnySpecExtractor:
    """Extract Dafny specifications from code"""
    
    def __init__(self):
        self.detector = DeclarationDetector()
        self.extractor = BlockExtractor()
        self.parser = ContractParser()
        self.builder = SpecBuilder()
    
    def extract_specifications(self, code: str) -> Dict[str, List[Dict[str, Any]]]:
        """Extract all Dafny specifications from code"""
        specs = {
            'methods': [],
            'functions': [],
            'predicates': [],
            'datatypes': [],
            'lemmas': []
        }
        
        lines = code.split('\n')
        i = 0
        
        while i < len(lines):
            line = lines[i].strip()
            detection = self.detector.detect_declaration(line)
            
            if detection:
                decl_type, name = detection
                block, next_i = self.extractor.extract_block(lines, i)
                
                if decl_type in ['method', 'lemma']:
                    spec = self._parse_method_like(block, name)
                    target = 'lemmas' if decl_type == 'lemma' else 'methods'
                    specs[target].append(spec)
                elif decl_type in ['function', 'predicate']:
                    spec = self._parse_function_like(block, name)
                    specs[f'{decl_type}s'].append(spec)
                
                i = next_i
            else:
                i += 1
        
        return specs
    
    def _parse_method_like(self, block: List[str], name: str) -> Dict[str, Any]:
        """Parse method or lemma block"""
        signature = block[0].strip()
        contracts = self.parser.parse_contracts(block)
        return self.builder.build_spec(name, signature, contracts, block)
    
    def _parse_function_like(self, block: List[str], name: str) -> Dict[str, Any]:
        """Parse function or predicate block"""
        signature = block[0].strip()
        contracts = self.parser.parse_contracts(block)
        return self.builder.build_spec(name, signature, contracts, block)


class DafnySpecValidator:
    """Validate Dafny implementations against specifications"""
    
    def __init__(self):
        self.extractor = DafnySpecExtractor()
    
    def validate_implementation(self, original_spec: str, implementation: str) -> Dict[str, Any]:
        """Validate implementation adheres to original specification"""
        original_specs = self.extractor.extract_specifications(original_spec)
        impl_specs = self.extractor.extract_specifications(implementation)
        
        result = {'valid': True, 'errors': [], 'warnings': []}
        
        # Check for axiom usage
        if '{:axiom}' in implementation:
            result['errors'].append('Use of {:axiom} attribute is not allowed')
            result['valid'] = False
        
        # Check for assume statements
        if re.search(r'\bassume\b', implementation):
            result['errors'].append('Use of assume statements is not allowed')
            result['valid'] = False
        
        # Validate all declaration types
        for spec_type in ['methods', 'lemmas', 'functions', 'predicates']:
            self._validate_spec_type(original_specs[spec_type], impl_specs[spec_type], 
                                    spec_type, result)
        
        return result
    
    def _validate_spec_type(self, original_list: List[Dict], impl_list: List[Dict],
                           spec_type: str, result: Dict):
        """Validate a specific type of specification"""
        # Only validate that original declarations are preserved with correct specs
        # Extra helper lemmas/functions are allowed as long as they're proven
        
        for orig in original_list:
            impl = self._find_by_name(orig['name'], impl_list)
            if not impl:
                result['errors'].append(f"{spec_type[:-1].capitalize()} {orig['name']} not found")
                result['valid'] = False
                continue
            
            self._validate_clauses(orig, impl, result)
    
    @staticmethod
    def _find_by_name(name: str, spec_list: List[Dict]) -> Optional[Dict]:
        """Find spec by name"""
        for spec in spec_list:
            if spec['name'] == name:
                return spec
        return None
    
    def _validate_clauses(self, original: Dict, implementation: Dict, result: Dict):
        """Validate requires and ensures clauses"""
        orig_requires = set(original['requires'])
        impl_requires = set(implementation['requires'])
        
        # Check requires clauses - must match exactly (no additions, no removals)
        extra = impl_requires - orig_requires
        missing = orig_requires - impl_requires
        
        if extra:
            result['errors'].append(f"{implementation['name']} has extra requires: {extra}")
            result['valid'] = False
        if missing:
            result['errors'].append(f"{implementation['name']} missing requires: {missing}")
            result['valid'] = False
        
        # Check ensures clauses - original ensures must be preserved, but extra ensures are allowed
        orig_ensures = set(original['ensures'])
        impl_ensures = set(implementation['ensures'])
        missing_ensures = orig_ensures - impl_ensures
        
        if missing_ensures:
            result['errors'].append(f"{implementation['name']} missing ensures: {missing_ensures}")
            result['valid'] = False
        
        # Extra ensures clauses are allowed - they strengthen the postcondition
