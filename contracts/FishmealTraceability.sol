/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract FishmealTraceability {
    uint256 public constant SCALE_FACTOR = 100;
    uint256 public anchovy_batch_counter = 0;
    uint256 public fishmeal_batch_counter = 0;
    uint256 public fishmeal_package_batch_counter = 0;

    struct AnchovyBatch {
        uint256 id;
        string enterprise;
        uint256 kilograms;
        string fishingArea;
        bool exist;
        uint256 createdAt;
    }
    
    struct FishmealBatch {
        uint256 id;
        uint256 kilograms;
        string processor_name ;
        uint256 id_anchovy_batch;
        bool exist;
        uint256 createdAt;
    }

    struct FishmealPackages {
        uint256 id;
        string distributor;
        uint256 fishmeal_batch_id;
        uint256 init_packages_id;
        uint256 packagesCount;
        uint256 final_packages_id;
        uint256 createdAt;
        bool exist;
    }

    event AnchovyBatchCreated(
        uint256 id,
        string enterprise,
        uint256 kilograms,
        string fishingArea,
        bool exist,
        uint256 createdAt
    );

    event FishmealBatchCreated(
        uint256 id,
        uint256 kilograms,
        string processor_name,
        uint256 id_anchovy_batch,
        bool exist,
        uint256 craetedAt
    );

    event FishmealPackagesCreated(
        uint256 id,
        string distributor,
        uint256 fishmeal_batch_id,
        uint256 init_packages_id,
        uint256 packagesCount,
        uint256 final_packages_id,
        uint256 createdAt,
        bool exist
    );

    event AnchovyBatchToggleExist(uint id, bool exist);
    event FishmealBatchToggleExist(uint id, bool exist);
    event FishmealPackagesToggleExist(uint id, bool exist);

    mapping(uint256 => AnchovyBatch) public anchovy_batches;
    mapping(uint256 => FishmealBatch) public fishmeal_batches;
    mapping(uint256 => FishmealPackages) public fishmeal_packages_batches;

    function createAnchovyBatch(string memory _enterprise, uint256 _kilograms, string memory _fishingArea) public {
        anchovy_batch_counter++;
        anchovy_batches[anchovy_batch_counter] = AnchovyBatch(
            anchovy_batch_counter,
            _enterprise,
            _kilograms,
            _fishingArea,
            true,
            block.timestamp
        );   
        emit AnchovyBatchCreated(anchovy_batch_counter, _enterprise, _kilograms, _fishingArea, true, block.timestamp);
    }

    function createFishmealBatch(uint256 _kilograms, string memory _processor_name, uint256 _id_anchovy_batch) public {
        fishmeal_batch_counter++;
        fishmeal_batches[fishmeal_batch_counter] = FishmealBatch(
            fishmeal_batch_counter,
            _kilograms,
            _processor_name,
            _id_anchovy_batch,
            true,
            block.timestamp
        );
        emit FishmealBatchCreated(fishmeal_batch_counter, _kilograms, _processor_name, _id_anchovy_batch, true, block.timestamp);
    }

    function createFishmealPackages(uint256 _fishmeal_batch_id, string memory _distributor, uint256 _packages_count) public {
        fishmeal_package_batch_counter++;
        fishmeal_packages_batches[fishmeal_package_batch_counter] = FishmealPackages(
            fishmeal_package_batch_counter,
            _distributor,
            _fishmeal_batch_id,
            1,
            _packages_count,
            _packages_count,
            block.timestamp,
            true
        );
        emit FishmealPackagesCreated(fishmeal_package_batch_counter, _distributor, _fishmeal_batch_id, 1, _packages_count, _packages_count, block.timestamp, true);
    }

    function toggleExistAnchovyBatch(uint256 _id) public {
        AnchovyBatch memory _anchovyBatch =  anchovy_batches[_id];
        _anchovyBatch.exist = !_anchovyBatch.exist;
        emit AnchovyBatchToggleExist(_id, _anchovyBatch.exist);
    }
    function toggleExistFishmealBatch(uint256 _id) public {
          FishmealBatch memory _fishmealBatch = fishmeal_batches[_id];
         _fishmealBatch.exist = !_fishmealBatch.exist;
         emit FishmealBatchToggleExist(_id, _fishmealBatch.exist);
    }
    function toggleExistFishemealPackagesBatch(uint256 _id) public {
        FishmealPackages memory _fishmealPackagesBatch = fishmeal_packages_batches[_id];
        _fishmealPackagesBatch.exist = _fishmealPackagesBatch.exist;
        emit FishmealPackagesToggleExist(_id, _fishmealPackagesBatch.exist);
    }
   
}