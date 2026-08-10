# ErlPay - Payment System Proof of Concept

A learning-focused payment system application built in Erlang. This project demonstrates core Erlang concepts including functions, pattern matching, error handling, and transaction management.

## Overview

ErlPay is a POC (Proof of Concept) for a payment system that showcases:
- **Transaction Management**: Record and track all money transfers
- **Payment Processing**: Transfer money between accounts
- **Transaction History**: Complete audit trail of all transactions
- **Payment Status Tracking**: Monitor payment states
- **Error Handling & Validation**: Robust validation and error handling with guards and pattern matching
- **Receipt Management**: Generate transaction receipts
- **Idempotency**: Future support for idempotent operations

## Key Features

### Implemented
- ✅ Core payment transfer functionality
- ✅ Transaction recording and storage
- ✅ Payment status tracking
- ✅ Comprehensive validation and error handling
- ✅ Erlang fundamentals (Functions, Maps, Guards, Case expressions, Tuples, Pattern Matching)
- ✅ Transaction auditing capabilities

### Planned
- 🔄 Idempotent payment operations
- 🔄 Advanced receipt generation

## Technology Stack

- **Language**: Erlang
- **Concepts Used**:
  - Functions and Higher-Order Functions
  - Maps for data structures
  - Guards for validation
  - Case expressions for control flow
  - Tuples and Pattern Matching
  - Error handling with try-catch patterns

## Project Structure

```
ErlPay/
├── README.md                 # This file
├── *.erl                      # Erlang source files
```

## Development Progress

### Commit History

1. **Initial Commit** - Project foundation
2. **Validation and Error Handling** - Case expressions, guards, tuples, and error patterns
3. **Functions, Maps, Guards** - Core Erlang concepts (functions, maps, guards, case expressions, tuples, pattern matching)
4. **Transactions & Payment Records** - Transaction history, payment status, auditing, troubleshooting, receipts

## Getting Started

### Prerequisites

- **Erlang/OTP** (version 24 or later recommended)
  
  **Installation**:
  ```bash
  # macOS
  brew install erlang
  
  # Ubuntu/Debian
  sudo apt-get install erlang erlang-dev
  
  # From source
  # Download from https://www.erlang.org/downloads
  ```

### Compilation

Compile all Erlang modules:

```bash
erl -make
```

Or compile individual files in the Erlang shell:

```bash
erl
> c(module_name).
```

## Testing Changes

### Running the Erlang Shell

```bash
erl
```

### Basic Testing Examples

#### 1. Test Transaction Creation and Recording

```erlang
% Start the Erlang shell
erl

% Compile modules (adjust filenames as needed)
> c(payment).
> c(transaction).

% Test basic payment transfer
> payment:transfer(account1, account2, 100).

% Check transaction history
> transaction:get_history(account1).

% Verify payment status
> transaction:get_status(transaction_id).
```

#### 2. Test Error Handling and Validation

```erlang
% Test invalid amount (should trigger error handling)
> payment:transfer(account1, account2, -50).

% Test invalid account (should fail validation)
> payment:transfer(invalid_account, account2, 100).

% Test with guards
> payment:validate_amount(100).  % Should succeed
> payment:validate_amount(-100). % Should fail with guard error
```

#### 3. Test Pattern Matching

```erlang
% Create test transactions
> Transaction = {transaction, account1, account2, 100, "pending"},
> case Transaction of
>   {transaction, From, To, Amount, Status} ->
>     io:format("Transfer ~p -> ~p: ~p (~s)~n", [From, To, Amount, Status])
> end.
```

#### 4. Test Maps Operations

```erlang
% Create account map
> Account = #{id => account1, balance => 1000, status => active},
> io:format("Account: ~p~n", [Account]).

% Update balance
> UpdatedAccount = Account#{balance => 900},
> io:format("Updated Account: ~p~n", [UpdatedAccount]).
```

#### 5. Comprehensive Integration Test

```erlang
% Compile all modules
> c(payment), c(transaction), c(account).

% Perform series of transactions
> payment:transfer(alice, bob, 500).
> payment:transfer(bob, charlie, 200).
> payment:transfer(charlie, alice, 100).

% Review transaction history
> transaction:get_all_transactions().

% Check audit trail
> transaction:get_audit_log().

% Verify payment statuses
> transaction:get_all_statuses().
```

## Erlang Concepts Covered

### Pattern Matching
- Extracting values from data structures
- Matching function arguments
- Destructuring tuples and maps

### Guards
- Validating conditions in function clauses
- Type checking
- Value range validation

### Maps
- Key-value data structures
- Account and transaction storage
- State management

### Error Handling
- Try-catch patterns
- Custom error tuples
- Error propagation

### Tuples
- Multi-value data grouping
- Status representations
- Transaction records

## Development Tips

1. **Use the Shell**: The Erlang shell is great for testing individual functions
2. **Reload Modules**: Use `c(module_name).` to recompile and reload
3. **Tracing**: Use `erlang:trace/3` for debugging complex issues
4. **Pattern Matching**: Test your patterns iteratively
5. **Guards**: Write guards to fail fast on invalid inputs

## Learning Resources

- [Erlang Official Documentation](https://www.erlang.org/doc)
- [Learn You Some Erlang](https://learnyousomeerlang.com/)
- [Erlang Programming Guide](https://www.erlang.org/doc/reference_manual/part_frame.html)

## Future Enhancements

- [ ] Implement idempotent operations
- [ ] Add receipt generation
- [ ] Create concurrent transaction processing
- [ ] Add persistence layer
- [ ] Implement distributed transactions
- [ ] Add logging and monitoring
- [ ] Create REST API wrapper (optional)

## Notes

This is a learning project. While it demonstrates key Erlang concepts, it is not intended for production use.

## License

Open source - use freely for learning purposes.

## Author

Created by [crussaders](https://github.com/crussaders)

---

**Last Updated**: August 10, 2026
