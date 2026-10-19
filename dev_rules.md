# Development Rule: Minimal Constructor Parameters

- Do not add many variables to widget constructors.  
- Instead, pass a single model object that encapsulates needed data or dependencies.  
- Prefer using existing state management (e.g., Cubit) via context rather than injecting many parameters.