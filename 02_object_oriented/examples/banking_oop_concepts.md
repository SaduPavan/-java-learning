# OOP Concepts in Banking Industry - Interview Guide

## 1. Encapsulation in Banking

Encapsulation is about bundling data and methods that operate on that data within a single unit (class) and restricting access to some of the object's components.

### Real-World Banking Example:
```java
public class BankAccount {
    // Private data members (encapsulation)
    private String accountNumber;
    private double balance;
    private String accountHolder;
    private String accountType;
    private List<Transaction> transactionHistory;
    
    // Constructor
    public BankAccount(String accountHolder, String accountType) {
        this.accountNumber = generateAccountNumber();
        this.balance = 0.0;
        this.accountHolder = accountHolder;
        this.accountType = accountType;
        this.transactionHistory = new ArrayList<>();
    }
    
    // Public methods to access and modify data (controlled access)
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            transactionHistory.add(new Transaction("DEPOSIT", amount));
        }
    }
    
    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            transactionHistory.add(new Transaction("WITHDRAWAL", amount));
            return true;
        }
        return false;
    }
    
    public double getBalance() {
        return balance;
    }
    
    public List<Transaction> getTransactionHistory() {
        return new ArrayList<>(transactionHistory); // Return copy for security
    }
    
    private String generateAccountNumber() {
        // Private method for internal use only
        return "ACC" + System.currentTimeMillis();
    }
}
```

**Interview Explanation:**
- "Encapsulation in banking is like a secure vault. The vault (class) contains valuable items (data) and has specific procedures (methods) to access them."
- "For example, a bank account's balance is private, and you can only modify it through controlled methods like deposit() and withdraw()."
- "This ensures data integrity and security, as direct access to sensitive data is prevented."

## 2. Abstract Class in Banking

Abstract classes are used when you want to share code among several related classes while declaring some methods that must be implemented by subclasses.

### Real-World Banking Example:
```java
public abstract class BankAccount {
    protected String accountNumber;
    protected double balance;
    protected String accountHolder;
    
    public BankAccount(String accountHolder) {
        this.accountNumber = generateAccountNumber();
        this.balance = 0.0;
        this.accountHolder = accountHolder;
    }
    
    // Common methods for all accounts
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    // Abstract methods that must be implemented by subclasses
    public abstract double calculateInterest();
    public abstract void applyMonthlyFees();
    public abstract double getMinimumBalance();
    
    // Common utility method
    protected String generateAccountNumber() {
        return "ACC" + System.currentTimeMillis();
    }
}

// Concrete implementation
public class SavingsAccount extends BankAccount {
    private static final double INTEREST_RATE = 0.05;
    private static final double MINIMUM_BALANCE = 1000.0;
    
    public SavingsAccount(String accountHolder) {
        super(accountHolder);
    }
    
    @Override
    public double calculateInterest() {
        return balance * INTEREST_RATE;
    }
    
    @Override
    public void applyMonthlyFees() {
        if (balance < MINIMUM_BALANCE) {
            balance -= 10.0; // Monthly maintenance fee
        }
    }
    
    @Override
    public double getMinimumBalance() {
        return MINIMUM_BALANCE;
    }
}

public class CheckingAccount extends BankAccount {
    private static final double INTEREST_RATE = 0.01;
    private static final double MINIMUM_BALANCE = 500.0;
    
    public CheckingAccount(String accountHolder) {
        super(accountHolder);
    }
    
    @Override
    public double calculateInterest() {
        return balance * INTEREST_RATE;
    }
    
    @Override
    public void applyMonthlyFees() {
        // No monthly fees for checking accounts
    }
    
    @Override
    public double getMinimumBalance() {
        return MINIMUM_BALANCE;
    }
}
```

**Interview Explanation:**
- "Abstract classes in banking are like account templates. For example, all bank accounts share common features (deposit, withdraw) but have different rules for interest calculation and fees."
- "The abstract BankAccount class defines the common structure and behavior, while specific account types (SavingsAccount, CheckingAccount) implement their unique rules."
- "This promotes code reuse while allowing for specific implementations."

## 3. Interface in Banking

Interfaces define a contract that implementing classes must follow, focusing on what a class can do rather than how it does it.

### Real-World Banking Example:
```java
// Interface for payment processing
public interface PaymentProcessor {
    boolean processPayment(double amount);
    void refundPayment(double amount);
    String getTransactionStatus(String transactionId);
}

// Interface for interest calculation
public interface InterestBearing {
    double calculateInterest();
    void applyInterest();
}

// Interface for account notifications
public interface AccountNotifier {
    void sendBalanceAlert(double balance);
    void sendTransactionAlert(Transaction transaction);
}

// Class implementing multiple interfaces
public class PremiumSavingsAccount extends BankAccount 
    implements PaymentProcessor, InterestBearing, AccountNotifier {
    
    private static final double INTEREST_RATE = 0.06;
    private static final double MINIMUM_BALANCE = 5000.0;
    
    public PremiumSavingsAccount(String accountHolder) {
        super(accountHolder);
    }
    
    // PaymentProcessor implementation
    @Override
    public boolean processPayment(double amount) {
        if (balance >= amount) {
            balance -= amount;
            return true;
        }
        return false;
    }
    
    @Override
    public void refundPayment(double amount) {
        balance += amount;
    }
    
    @Override
    public String getTransactionStatus(String transactionId) {
        // Implementation for transaction status check
        return "COMPLETED";
    }
    
    // InterestBearing implementation
    @Override
    public double calculateInterest() {
        return balance * INTEREST_RATE;
    }
    
    @Override
    public void applyInterest() {
        balance += calculateInterest();
    }
    
    // AccountNotifier implementation
    @Override
    public void sendBalanceAlert(double balance) {
        if (balance < MINIMUM_BALANCE) {
            // Send alert to account holder
            System.out.println("Low balance alert: " + balance);
        }
    }
    
    @Override
    public void sendTransactionAlert(Transaction transaction) {
        // Send transaction notification
        System.out.println("Transaction alert: " + transaction);
    }
}
```

**Interview Explanation:**
- "Interfaces in banking are like service contracts. For example, a premium savings account might implement multiple interfaces like PaymentProcessor, InterestBearing, and AccountNotifier."
- "This allows the account to process payments, calculate interest, and send notifications, while keeping these functionalities separate and modular."
- "Different account types can implement different combinations of interfaces based on their features."

## Key Differences for Interview

1. **Encapsulation vs Abstract Class vs Interface**
   - Encapsulation: Data hiding and controlled access
   - Abstract Class: Partial implementation with shared code
   - Interface: Pure contract with no implementation

2. **When to Use Each**
   - Encapsulation: When you need to protect data and control access
   - Abstract Class: When you have common code to share among related classes
   - Interface: When you want to define a contract that multiple unrelated classes can implement

3. **Real-World Banking Analogy**
   - Encapsulation: Like a bank vault with controlled access
   - Abstract Class: Like different types of bank accounts sharing common features
   - Interface: Like banking services that different account types can offer

Remember: In interviews, use these banking examples to demonstrate your understanding of these concepts in a real-world context. The examples show how these OOP concepts are actually used in industry applications. 