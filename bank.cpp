#include <iostream>
#include <string>

class BankAccount {
protected:
    unsigned int accountNumber;
    std::string holderName;
    double balance;

public:
    BankAccount(unsigned int accNum, const std::string& name, double bal): accountNumber(accNum), holderName(name) {
        balance = bal > 0 ? bal : 0;
    }
    virtual ~BankAccount() = default;
    
    void deposit(double addBalance) {
        balance += addBalance > 0 ? addBalance : 0;
    }

    void withdraw(double subBalance) {
        subBalance = subBalance > 0 ? subBalance : 0;
        balance = (balance - subBalance > 0) ? balance - subBalance : 0; 
    }

    unsigned int getAccountNumber() {
        return accountNumber;
    }

    std::string getHolderName() {
        return holderName;
    }

    double getBalance() {
        return balance;
    }
};

class SavingsAccount : public BankAccount {
private:
    unsigned short interestRate;

public:
    SavingsAccount(unsigned int accNum, const std::string& name, double bal, unsigned short intRate): BankAccount(accNum, name, bal), interestRate(intRate) {}

    void accrueInterestOn() {
        balance += (balance * interestRate/100);
    }

    unsigned short getInterestRate() {
        return interestRate;
    }
};

int main() {
    BankAccount bankAccount(122, "Melly", 2323.4);
    SavingsAccount savingsAccount(2313, "Molly", 23123123.2, 15);

    bankAccount.deposit(111);
    bankAccount.withdraw(111);

    savingsAccount.accrueInterestOn();

    return 0;
}