select *
from dbo.Sheet1$ 
where OwnerAddress is  null
order by [UniqueID ];

-- Standardize Date Format

select saleDate,CONVERT(date,SaleDate)
from dbo.Sheet1$;


update Sheet1$
set SaleDate = 	CONVERT(date,SaleDate)


ALTER TABLE Sheet1$
Add SaleDateconverted Date;

Update Sheet1$
SET SaleDateconverted = CONVERT(Date,SaleDate)

Update Sheet1$
SET SaleDate = SaleDateconverted

select *
from dbo.Sheet1$ 
order by [UniqueID ]


ALTER TABLE Sheet1$
DROP COLUMN SaleDate1;

------- Populate Property Address data

select * 
from dbo.Sheet1$
where PropertyAddress is null 
order by [UniqueID ];

select ParcelID,COUNT(ParcelID) 
from dbo.Sheet1$
group by ParcelID
having COUNT(ParcelID)>1;

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from dbo.Sheet1$ a
join dbo.Sheet1$ b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

update a
set PropertyAddress =  ISNULL(a.PropertyAddress,b.PropertyAddress)
from dbo.Sheet1$ a
join dbo.Sheet1$ b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

select PropertyAddress
from dbo.Sheet1$
where PropertyAddress is null
order by ParcelID ;


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
from dbo.Sheet1$

alter table Sheet1$
add PropertySplitAddress Nvarchar(255);

Update Sheet1$
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE Sheet1$
Add PropertySplitCity Nvarchar(255);

Update Sheet1$
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From dbo.Sheet1$


Select OwnerAddress
From dbo.Sheet1$


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From dbo.Sheet1$



ALTER TABLE Sheet1$
Add OwnerSplitAddress Nvarchar(255);

Update Sheet1$
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Sheet1$
Add OwnerSplitCity Nvarchar(255);

Update Sheet1$
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Sheet1$
Add OwnerSplitState Nvarchar(255);

Update Sheet1$
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From dbo.Sheet1$

--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From dbo.Sheet1$
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From dbo.Sheet1$

Update Sheet1$
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


