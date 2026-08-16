# ErlPay - Payment System Proof of Concept

A learning-focused payment system application built in Erlang. This project demonstrates core Erlang/OTP concepts including gen_server usage, supervisors, pattern matching, error handling, and transaction management.

## Overview

ErlPay is a POC (Proof of Concept) for a payment system that showcases:
- **OTP Concurrency**: gen_server-based processes to handle payment logic
- **Supervisor-based supervision**: OTP supervisors monitor and restart worker processes
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
- ✅ Transaction recording and storage (every transfer is recorded)
- ✅ Payment status tracking
- ✅ Comprehensive validation and error handling
- ✅ Erlang/OTP fundamentals (gen_server, supervisors, functions, maps, guards, case expressions, tuples, pattern matching)
- ✅ Transaction auditing capabilities

### Planned
- 🔄 Idempotent payment operations
- 🔄 Advanced receipt generation
- 🔄 Persistence layer and distributed transactions

## Technology Stack

- **Language**: Erlang
- **OTP Components**:
  - gen_server: payment and transaction worker processes
  - supervisor: monitors worker processes and restarts on failure
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
├── *.erl                      # Erlang source files (payment, transaction, account, etc.)
```

## Development Progress

### Commit History (high level)

1. **Initial Commit** - Project foundation
2. **Validation and Error Handling** - Case expressions, guards, tuples, and error patterns
3. **Functions, Maps, Guards** - Core Erlang concepts
4. **Transactions & Payment Records** - Transaction history, payment status, auditing, receipts
5. **gen_server initializing** - Added gen_server-based workers
6. **OTP Supervisor** - Documented and added supervisor to monitor processes

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

## Running & Testing

Start the Erlang shell, compile modules, and interact with gen_server processes.

```erlang
% Start shell
erl

% Compile modules (adjust filenames as needed)
> c(payment).
> c(transaction).

% If the application starts an OTP supervisor, start the application instead
% in a real setup: application:start(erlpay).

% Example: perform a transfer via payment gen_server
> payment:transfer(Account1, Account2, 100).

% Check transaction history
> transaction:get_history(Account1).
```

## Testing Examples

(Examples retained from previous version; adjust module names to match the code in this repo.)

## Erlang Concepts Covered

- Pattern Matching
- Guards
- Maps
- Error Handling
- Tuples

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
- [ ] Create concurrent transaction processing improvements
- [ ] Add persistence layer
- [ ] Implement distributed transactions
- [ ] Add logging and monitoring
- [ ] Create REST API wrapper (optional)

## Notes

This is a learning project. While it demonstrates key Erlang/OTP concepts, it is not intended for production use.

## License

Open source - use freely for learning purposes.

## Author

Created by [crussaders](https://github.com/crussaders)

---

**Last Updated**: August 16, 2026

## What is ETS?

ETS (Erlang Term Storage) is an in-memory storage system built into Erlang. It's very fast because it's stored in memory.
