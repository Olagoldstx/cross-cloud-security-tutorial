# Lab 1: Azure AD Users and RBAC Assignments

## 🎯 Lab Objectives
- Create Azure AD users and groups
- Configure Azure RBAC role assignments
- Create and test Managed Identities
- Understand Azure permission inheritance

## ⏱️ Time Estimate: 30-45 minutes

## 📋 Lab Scenario
As CloudCorp's security engineer, extend IAM practices to Azure.

## 🚀 Step-by-Step Lab

### Step 1: Access Azure Portal
1. Navigate to portal.azure.com
2. Sign in with your Azure account

### Step 2: Create Azure AD User
1. In Azure AD, go to Users → New user
2. Create user: devuser@yourdomain.onmicrosoft.com

### Step 3: Create Resource Group
1. Search for "Resource groups" → Create
2. Name: cloudcorp-rg-[your-initials]
3. Region: East US

### Step 4: Assign RBAC Role
1. Go to resource group
2. Click Access control (IAM) → Add role assignment
3. Assign Reader role to your user

## 🔧 Azure CLI Commands
Use Azure CLI to automate the process.

## 🧪 Validation Checklist
- [ ] Azure AD user created
- [ ] Resource group created
- [ ] RBAC role assigned

## 🧠 Cross-Cloud Comparison
Learn how Azure compares to AWS and GCP.

---
Lab completed! Ready for use.
