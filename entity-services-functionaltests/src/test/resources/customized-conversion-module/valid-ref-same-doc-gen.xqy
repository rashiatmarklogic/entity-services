xquery version "1.0-ml";

(:
 This module was generated by MarkLogic Entity Services.
 The  an XML node holding the canonical form of the source entity type.
 document was Northwind-Ref-Same-Document-0.0.1
 To use this module, examine how you wish to extract data from sources,
 and modify the various extract-instance-{X} functions to
 create the instances you wish.

 You may wish to/need to alter
 1.  values.  For example, creating duration values from decimal months.
 2.  references.  This conversion module assumes you want to denormalize
     instances when storing them in documents.  You may choose to remove
     code that denormalizes, and just include reference values in your
     instances instead.
 3.  Source XPath expressions.  The data coming into the extract-instance-{X}
     functions will probably not be exactly what this module predicts.

 After modifying this file, put it in your project for deployment to the modules
 database of your application, and check it into your source control system.

 Modification History:
 Generated at timestamp: 2016-10-20T14:13:46.810226-07:00
 Persisted by AUTHOR
 Date: DATE
 :)

module namespace northwind-Ref-Same-Document
    = "http://refSameDocument#Northwind-Ref-Same-Document-0.0.1";

import module namespace es = "http://marklogic.com/entity-services"
    at "/MarkLogic/entity-services/entity-services.xqy";

declare option xdmp:mapping "false";


(:
  extract-instance-{entity-type} functions

  These functions together take a source document and create a nested
  map structure from it.
  The resulting map is used by instance-to-canonical-xml to create documents
  in the database.

  It is expected that an implementer will edit at least XPath expressions in
  the extraction functions.  It is less likely that you will want to edit
  the instance-to-canonical-xml or envelope functions.
 :)


(:~
 : Creates a map:map instance from some source document.
 : @param $source-node  A document or node that contains
 :   data for populating a Customer
 : @return A map:map instance with extracted data and
 :   metadata about the instance.
 :)
declare function northwind-Ref-Same-Document:extract-instance-Customer(
    $source as node()?
) as map:map
{
    let $source-node :=
        if ( ($source instance of document-node())
            or (exists($source/Customer)))
        then $source/node()
        else $source
    let $instance := json:object()
    (: Add the original source document as an attachment. (optional, for lineage) :)
        =>map:with('$attachments',
            typeswitch($source-node)
            case object-node() return xdmp:quote($source)
            case array-node() return xdmp:quote($source)
            default return $source)
    (: Add type information to the entity instance (required, do not change) :)
        =>map:with('$type', 'Customer')
    return

    (: The following logic may not be required for every extraction       :)
    (: if this $source-node has no child elements, it has a reference key :)
    if (empty($source-node/*))
    then $instance=>map:with('$ref', $source-node/text())
    (: Otherwise, this source node contains instance data. Populate it. :)
    else

    (:
    The following code populates the properties of the 'Customer'
    entity type. Ensure that all of the property paths are correct for your
    source data.  The general pattern is
    =>map:with('keyName', casting-function($source-node/path/to/data))
    but you may also wish to convert values
    =>map:with('dateKeyName',
          xdmp:parse-dateTime("[Y0001]-[M01]-[D01]T[h01]:[m01]:[s01].[f1][Z]",
          $source-node/path/to/data/in/the/source))
    You can also implement lookup functions,
    =>map:with('lookupKey',
          cts:search( collection('customers'),
              string($source-node/path/to/lookup/key))/id
    or populate the instance with constants.
    =>map:with('constantValue', 10)
    The output of this function should structurally match the output of
    es:model-get-test-instances($model)
    :)

    $instance
    =>   map:with('CustomerId',             xs:string($source-node/@CustomerID))
    =>es:optional('CompanyName',            xs:string($source-node/CompanyName))
    =>es:optional('Country',                xs:string($source-node/Country))
    =>es:optional('Address',                xs:string($source-node/Address))
};

(:~
 : Creates a map:map instance from some source document.
 : @param $source-node  A document or node that contains
 :   data for populating a Product
 : @return A map:map instance with extracted data and
 :   metadata about the instance.
 :)
declare function northwind-Ref-Same-Document:extract-instance-Product(
    $source as node()?
) as map:map
{
    let $source-node :=
        if ( ($source instance of document-node())
            or (exists($source/Product)))
        then $source/node()
        else $source
    let $instance := json:object()
    (: Add the original source document as an attachment. (optional, for lineage) :)
        =>map:with('$attachments',
            typeswitch($source-node)
            case object-node() return xdmp:quote($source)
            case array-node() return xdmp:quote($source)
            default return $source)
    (: Add type information to the entity instance (required, do not change) :)
        =>map:with('$type', 'Product')
    return

    (: The following logic may not be required for every extraction       :)
    (: if this $source-node has no child elements, it has a reference key :)
    if (empty($source-node/*))
    then $instance=>map:with('$ref', $source-node/text())
    (: Otherwise, this source node contains instance data. Populate it. :)
    else

    (:
    The following code populates the properties of the 'Product'
    entity type. Ensure that all of the property paths are correct for your
    source data.  The general pattern is
    =>map:with('keyName', casting-function($source-node/path/to/data))
    but you may also wish to convert values
    =>map:with('dateKeyName',
          xdmp:parse-dateTime("[Y0001]-[M01]-[D01]T[h01]:[m01]:[s01].[f1][Z]",
          $source-node/path/to/data/in/the/source))
    You can also implement lookup functions,
    =>map:with('lookupKey',
          cts:search( collection('customers'),
              string($source-node/path/to/lookup/key))/id
    or populate the instance with constants.
    =>map:with('constantValue', 10)
    The output of this function should structurally match the output of
    es:model-get-test-instances($model)
    :)

    $instance
    =>es:optional('ProductName',            xs:string($source-node/ProductName))
    =>es:optional('ProductID',              xs:integer($source-node/@ProductID))
    =>es:optional('UnitPrice',              xs:integer($source-node/UnitPrice))
    =>es:optional('SupplierID',             xs:integer($source-node/SupplierID))
    =>es:optional('Discontinued',           xs:boolean($source-node/Discontinued))
};

(:~
 : Creates a map:map instance from some source document.
 : @param $source-node  A document or node that contains
 :   data for populating a Order
 : @return A map:map instance with extracted data and
 :   metadata about the instance.
 :)
declare function northwind-Ref-Same-Document:extract-instance-Order(
    $source as node()?
) as map:map
{
    let $source-node :=
        if ( ($source instance of document-node())
            or (exists($source/Order)))
        then $source/node()
        else $source
    let $instance := json:object()
    (: Add the original source document as an attachment. (optional, for lineage) :)
        =>map:with('$attachments',
            typeswitch($source-node)
            case object-node() return xdmp:quote($source)
            case array-node() return xdmp:quote($source)
            default return $source)
    (: Add type information to the entity instance (required, do not change) :)
        =>map:with('$type', 'Order')
    return

    (: The following logic may not be required for every extraction       :)
    (: if this $source-node has no child elements, it has a reference key :)
    if (empty($source-node/*))
    then $instance=>map:with('$ref', $source-node/text())
    (: Otherwise, this source node contains instance data. Populate it. :)
    else

    (:
    The following code populates the properties of the 'Order'
    entity type. Ensure that all of the property paths are correct for your
    source data.  The general pattern is
    =>map:with('keyName', casting-function($source-node/path/to/data))
    but you may also wish to convert values
    =>map:with('dateKeyName',
          xdmp:parse-dateTime("[Y0001]-[M01]-[D01]T[h01]:[m01]:[s01].[f1][Z]",
          $source-node/path/to/data/in/the/source))
    You can also implement lookup functions,
    =>map:with('lookupKey',
          cts:search( collection('customers'),
              string($source-node/path/to/lookup/key))/id
    or populate the instance with constants.
    =>map:with('constantValue', 10)
    The output of this function should structurally match the output of
    es:model-get-test-instances($model)
    :)

    $instance
    =>es:optional('OrderID',                xs:integer($source-node/@OrderID))
    =>es:optional('CustomerID',             xs:integer($source-node/CustomerID))
    =>es:optional('OrderDate',              xs:dateTime($source-node/OrderDate))
    =>es:optional('ShipAddress',            xs:string($source-node/ShipAddress))
    (: The following property is a local reference.  :)
    =>es:optional('OrderDetails',           es:extract-array($source-node/OrderDetails/*, northwind-Ref-Same-Document:extract-instance-OrderDetail#1))
};

(:~
 : Creates a map:map instance from some source document.
 : @param $source-node  A document or node that contains
 :   data for populating a OrderDetail
 : @return A map:map instance with extracted data and
 :   metadata about the instance.
 :)
declare function northwind-Ref-Same-Document:extract-instance-OrderDetail(
    $source as node()?
) as map:map
{
    let $source-node :=
        if ( ($source instance of document-node())
            or (exists($source/OrderDetail)))
        then $source/node()
        else $source
    let $instance := json:object()
    (: Add the original source document as an attachment. (optional, for lineage) :)
        =>map:with('$attachments',
            typeswitch($source-node)
            case object-node() return xdmp:quote($source)
            case array-node() return xdmp:quote($source)
            default return $source)
    (: Add type information to the entity instance (required, do not change) :)
        =>map:with('$type', 'OrderDetail')
    return

    (: The following logic may not be required for every extraction       :)
    (: if this $source-node has no child elements, it has a reference key :)
    if (empty($source-node/*))
    then $instance=>map:with('$ref', $source-node/text())
    (: Otherwise, this source node contains instance data. Populate it. :)
    else

    (:
    The following code populates the properties of the 'OrderDetail'
    entity type. Ensure that all of the property paths are correct for your
    source data.  The general pattern is
    =>map:with('keyName', casting-function($source-node/path/to/data))
    but you may also wish to convert values
    =>map:with('dateKeyName',
          xdmp:parse-dateTime("[Y0001]-[M01]-[D01]T[h01]:[m01]:[s01].[f1][Z]",
          $source-node/path/to/data/in/the/source))
    You can also implement lookup functions,
    =>map:with('lookupKey',
          cts:search( collection('customers'),
              string($source-node/path/to/lookup/key))/id
    or populate the instance with constants.
    =>map:with('constantValue', 10)
    The output of this function should structurally match the output of
    es:model-get-test-instances($model)
    :)

    $instance
    (: The following property is a local reference.  :)
    =>es:optional('productID',              northwind-Ref-Same-Document:extract-instance-Product($source-node/ProductID))
    =>es:optional('unitPrice',              xs:integer($source-node/UnitPrice))
    =>es:optional('Quantity',               xs:integer($source-node/Quantity))
};





(:~
 : Turns an entity instance into an XML structure.
 : This out-of-the box implementation traverses a map structure
 : and turns it deterministically into an XML tree.
 : Using this function as-is should be sufficient for most use
 : cases, and will play well with other generated artifacts.
 : @param $entity-instance A map:map instance returned from one of the extract-instance
 :    functions.
 : @return An XML element that encodes the instance.
 :)
declare function northwind-Ref-Same-Document:instance-to-canonical-xml(
    $entity-instance as map:map
) as element()
{
    (: Construct an element that is named the same as the Entity Type :)
    element { map:get($entity-instance, "$type") }  {
        if ( map:contains($entity-instance, "$ref") )
        then map:get($entity-instance, "$ref")
        else
            for $key in map:keys($entity-instance)
            let $instance-property := map:get($entity-instance, $key)
            where ($key castable as xs:NCName and $key ne "$type")
            return
                typeswitch ($instance-property)
                (: This branch handles embedded objects.  You can choose to prune
                   an entity's representation of extend it with lookups here. :)
                case json:object+
                    return
                        for $prop in $instance-property
                        return element { $key } { northwind-Ref-Same-Document:instance-to-canonical-xml($prop) }
                (: An array can also treated as multiple elements :)
                case json:array
                    return
                        for $val in json:array-values($instance-property)
                        return
                            if ($val instance of json:object)
                            then element { $key } {
                                attribute datatype { "array" },
                                northwind-Ref-Same-Document:instance-to-canonical-xml($val) }
                            else element { $key } {
                                attribute datatype { "array" },
                                $val }
                (: A sequence of values should be simply treated as multiple elements :)
                case item()+
                    return
                        for $val in $instance-property
                        return element { $key } { $val }
                default return element { $key } { $instance-property }
    }
};


(:
 : Wraps a canonical instance (returned by instance-to-canonical-xml())
 : within an envelope patterned document, along with the source
 : document, which is stored in an attachments section.
 : @param $entity-instance an instance, as returned by an extract-instance
 : function
 : @return A document which wraps both the canonical instance and source docs.
 :)
declare function northwind-Ref-Same-Document:instance-to-envelope(
    $entity-instance as map:map
) as document-node()
{
    document {
        element es:envelope {
            element es:instance {
                element es:info {
                    element es:title { map:get($entity-instance,'$type') },
                    element es:version { "0.0.1" }
                },
                northwind-Ref-Same-Document:instance-to-canonical-xml($entity-instance)
            },
            element es:attachments {
                map:get($entity-instance, "$attachments")
            }
        }
    }
};