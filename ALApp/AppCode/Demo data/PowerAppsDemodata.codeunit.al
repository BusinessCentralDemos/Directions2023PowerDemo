codeunit 52001 PowerAppsDemoDataGenerator
{
    procedure DeleteDemoDataForPowerApps()
    var
        itemRecord: Record Item;
        cutsomerRecord: Record Customer;
    begin
        // Delete all added items
        itemRecord.SetRange(IsAvialableForFieldWorker, true);
        itemRecord.DeleteAll(true);

        // Note: We are leaving the item catagories since they don't disturb much
    end;

    procedure GenerateDemoDataForPowerApps()
    begin
        GenerateDemoData();
    end;

    procedure GenerateDemoData()
    var
        itemRecord: Record Item;
        itemImageCodeUnit: Codeunit PowerAppsItemImages;
        itemimageCodeUnitExtra: Codeunit PowerAppsItemImagesExtra;
        tempImage: Text;
    begin

        // Add item catagories
        AddItemCatagories('Finished goods', 'finishedGoods');
        AddItemCatagories('Consumables', 'consumables');
        AddItemCatagories('Maintenance', 'maintenance');
        AddItemCatagories('Accessory', 'accessory');

        tempImage := itemImageCodeUnit.C0001_2018SandiagoSlim();

        // Add Coffee machines
        AddItem('CM001', 'Contoso SLIM 2018 San Diego', 'Contoso SLIM 2018 San Diego', 'finishedGoods', 699, tempImage);
        AddItem('CM002', 'Contoso SLIM 2019 Las Vegas', 'Contoso SLIM 2019 Las Vegas', 'finishedGoods', 850, itemImageCodeUnit.C0002_2019LasVegaSlim());
        AddItem('CM003', 'Contoso MINI 2018 San Diego', 'Contoso MINI 2018 San Diego', 'finishedGoods', 499, itemImageCodeUnit.C0003_2018SandiagoMini());
        AddItem('CM004', 'Contoso MINI 2022 Orlando', 'Contoso MINI 2022 Orlando', 'finishedGoods', 499, itemImageCodeUnit.C0004_2022OrlandoMini());
        AddItem('CM005', 'Contoso MINI 2023 Orlando', 'Contoso MINI 2023 Orlando', 'finishedGoods', 699, itemImageCodeUnit.C0005_2023OrlandoMini());
        AddItem('CM006', 'Contoso PRO SLIM 2023 Orlando', 'Contoso PRO SLIM 2023 Orlando', 'finishedGoods', 699, itemImageCodeUnit.C0006_2023OrlandoProSlim());
        AddItem('CM007', 'Contoso MINI 2019 Las Vegas', 'Contoso MIINI 2019 Las Vegas', 'finishedGoods', 699, itemImageCodeUnit.C0007_2019LasVegasMini());

        // Call AddItemUnitOfMeasure for each item with the corresponding ID   
        AddItemUnitOfMeasure('CM001');
        AddItemUnitOfMeasure('CM002');
        AddItemUnitOfMeasure('CM003');
        AddItemUnitOfMeasure('CM004');
        AddItemUnitOfMeasure('CM005');
        AddItemUnitOfMeasure('CM006');
        AddItemUnitOfMeasure('CM007');

        // Add extras items for coffee machines
        AddItem('E0001', 'Coffee beans', 'Freshly roasted beans for brewing coffee', 'consumables', 12, itemimageCodeUnitExtra.E0001_beans());
        AddItem('E0002', 'Paper filters', 'Disposable filters for drip or pour-over coffee makers', 'consumables', 6, itemimageCodeUnitExtra.E0002_paperFilters());
        AddItem('E0003', 'Descaling solution', 'Solution for removing mineral buildup from the coffee machine', 'consumables', 10, itemimageCodeUnitExtra.E0003_descaling());
        AddItem('E0004', 'Milk frothing pitcher', 'Stainless steel pitcher for steaming and frothing milk', 'consumables', 15, itemimageCodeUnitExtra.E0004_milkFrothePither());
        AddItem('E0005', 'Tamper', 'Tool used to compress ground coffee in the portafilter', 'accessory', 20, itemimageCodeUnitExtra.E0005_tamper());
        AddItem('E0006', 'Milk frother attachment', 'Attachment for making frothed milk for cappuccinos and lattes', 'accessory', 25, itemimageCodeUnitExtra.E0006_milkFrother());
        AddItem('E0007', 'Portafilter basket', 'Replacement or additional basket for the portafilter', 'accessory', 12, itemimageCodeUnitExtra.E0007_portaFilterBasket());
        AddItem('E0008', 'Knock box for used coffee grounds', 'Container for discarding used coffee grounds', 'accessory', 30, itemimageCodeUnitExtra.E0008_box());
        AddItem('E0009', 'Replacement water filter cartridge', 'Replacement cartridge for the water filtration system in the machine', 'accessory', 8, itemimageCodeUnitExtra.E0009_waterFilter());
        AddItem('E0010', 'Cleaning brush', 'Small brush for cleaning the grouphead, portafilter, and steam wand', 'maintenance', 7, itemimageCodeUnitExtra.E0010_CleaningBrush());
        AddItem('E0011', 'Grouphead cleaning powder', 'Powder for removing coffee oils and residue from the grouphead', 'maintenance', 9, itemimageCodeUnitExtra.E0011_CleaningPowder());
        AddItem('E0012', 'Steam wand cleaning solution', 'Solution for removing milk residue from the steam wand', 'maintenance', 12, itemimageCodeUnitExtra.E0012_SteamWandcleaningSolution());
        AddItem('E0013', 'Drip tray liners', 'Disposable liners for collecting drips and spills from the machine', 'maintenance', 5, itemimageCodeUnitExtra.E0013_DripTrayLiners());


        // Call AddItemUnitOfMeasure for each item with the corresponding ID
        AddItemUnitOfMeasure('E0001');
        AddItemUnitOfMeasure('E0002');
        AddItemUnitOfMeasure('E0003');
        AddItemUnitOfMeasure('E0004');
        AddItemUnitOfMeasure('E0005');
        AddItemUnitOfMeasure('E0006');
        AddItemUnitOfMeasure('E0007');
        AddItemUnitOfMeasure('E0008');
        AddItemUnitOfMeasure('E0009');
        AddItemUnitOfMeasure('E0010');
        AddItemUnitOfMeasure('E0011');
        AddItemUnitOfMeasure('E0012');
        AddItemUnitOfMeasure('E0013');

    end;

    procedure AddItem(ItemNumber: Text; ItemName: Text; description: Text; itemCategory: Text; unitPrice: Decimal; itemPicture: Text)
    var
        itemRecord: Record Item;
        inventoryGroup: Record "Inventory Posting Group";
        itemUnitOfMeasure: Record "Item Unit of Measure";
        genProdPostingGroup: Record "Gen. Product Posting Group";
        taxGroupCode: Record "Tax Group";
    begin
        // Note we can change these to be specific things if we want to 
        inventoryGroup.FindFirst();
        taxGroupCode.FindFirst();
        genProdPostingGroup.Get('RETAIL');

        if itemRecord.Get(ItemNumber) then
            exit;

        // Set up the item
        itemRecord.Init();
        itemRecord.Validate("No.", ItemNumber);
        itemRecord.Validate(Description, ItemName);
        itemRecord.Validate(LongDescription, description);
        itemRecord.Validate("Unit Price", unitPrice);
        itemRecord.Validate("Item Category Code", itemCategory);
        itemRecord.Validate("Inventory Posting Group", inventoryGroup.Code);
        itemRecord.Validate("Gen. Prod. Posting Group", genProdPostingGroup.Code);
        itemRecord.Validate("Tax Group Code", taxGroupCode.Code);
        itemRecord.Validate(IsAvialableForFieldWorker, true);
        addImageToItem(itemPicture, itemRecord);

        // Save the item
        itemRecord.Insert(true);
    end;


    procedure AddItemCatagories(description: Text; code: Text)
    var
        itemCatagory: Record "Item Category";
    begin
        if itemCatagory.Get(code) then
            exit;

        itemCatagory.Init();
        itemCatagory.Validate(description, description);
        itemCatagory.Validate(Code, code);
        itemCatagory.Insert(true);
    end;

    procedure AddItemUnitOfMeasure(itemNumber: Text)
    var
        itemUnitOfMeasure: Record "Item Unit of Measure";
        itemRecord: Record Item;
    begin
        itemUnitOfMeasure.SetRange("Item No.", itemNumber);
        itemUnitOfMeasure.SetRange(Code, 'PCS');
        if itemUnitOfMeasure.FindFirst() then
            exit;

        itemUnitOfMeasure.Init();
        itemUnitOfMeasure.Validate("Item No.", itemNumber);
        itemUnitOfMeasure.Validate(Code, 'PCS');
        itemUnitOfMeasure.Insert(true);

        itemRecord.Get(itemNumber);
        itemRecord.validate("Base Unit of Measure", 'PCS');
        itemRecord.Modify(true);
    end;

    procedure addImageToItem(Base64Img: Text; var itemRecord: Record Item)
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
    begin
        Outstr := TempBlob.CreateOutStream();
        Base64Convert.FromBase64(Base64Img, Outstr);
        itemRecord.Picture.ImportStream(TempBlob.CreateInStream(), 'Image demo data for Item');
    end;

}